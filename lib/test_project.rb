# frozen_string_literal: true

# Ensure that files in lib can be loaded easily in spec files without needing to
# use relative paths
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

class TestProject
  def initialize(options: {})
    @options = options
  end

  def bananas
    puts @options
    'bananas'
  end

  def yaml_parse
    YamlParser.new(@options[:yaml]).parse
  end
end

# Run this code only when started from the command-line
if __FILE__ == $PROGRAM_NAME
  require 'cli_options'
  options = CliOptions.new.parse(cli_args: ARGV)

  puts TestProject.new(options:).bananas
  puts TestProject.new(options:).yaml_parse
end
