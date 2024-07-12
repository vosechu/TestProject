# frozen_string_literal: true
require 'optparse'

class CliOptions
  attr_accessor :options

  def initialize
    @options = {}
  end

  def parse(cli_args: nil)
    OptionParser.new do |opts|
      opts.banner = 'Usage: test_project.rb [options]'

      opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
        options[:verbose] = v
      end

      opts.on('-y', '--yaml FILE', 'YAML file to load') do |file|
        options[:yaml] = file
      end.parse(cli_args)
    end
  end
end
