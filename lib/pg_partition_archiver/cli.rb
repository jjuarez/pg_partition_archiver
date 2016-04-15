#!/usr/bin/env ruby

require 'date'
require 'pg'


class PGPartition
  DEFAULT_SEPARATOR = '_'.freeze

  def self.days_of_the_year(year)
    Date.leap?(year) ? 366 : 365
  end

  def self.get_index(partition, options = { })
    options = { separator: DEFAULT_SEPARATOR }.merge(options)

    partition.split(options[:separator])[2].to_i
  end

  def load_partition(partition_pattern)

    @connection.exec("SELECT tablename AS partition FROM pg_tables WHERE tablename like '#{partition_pattern}' ORDER BY tablename ASC") do |rs|
      rs.each do |row|
        partition_index        = PGPartition.get_index(row['partition'])
        @data[partition_index] = row['partition'] 
      end
    end
  end

  def initialize(options)

    @connection = PG.connect(dbname: options[:dbname])
    @data       = Array.new(PGPartition.days_of_the_year(options[:year])) { nil }
    @retention  = options[:retention]

    load_partition(options[:partition_pattern])

    self
  end

  def archive(date=Time.now)
    index = date.yday - @retention 
    index if index != 0 && @data[index]
  end

  def inspect
    @data.inspect
  end
end


##
# ::main::
if __FILE__ == $0
  puts PGPartition.new(
    dbname:            'sipcapture', 
    partition_pattern: 'sip_capture_%',
    year:              Time.new.year,
    retention:         31).archive
end

