# frozen_string_literal: true

require 'yaml'

class YamlParser
  def initialize(file: nil, string: nil)
    @string = string
    @file = file
  end

  def parse
    @string = File.read(@file) if @file

    YAML.safe_load(@string)
  end
end
