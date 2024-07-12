# frozen_string_literal: true

require 'cli_options'

RSpec.describe CliOptions do
  subject { described_class.new }

  describe '#parse' do
    context 'when given valid command line arguments' do
      let(:cli_args) { ['-v', '-y', 'config.yaml'] }

      it 'sets the verbose option to true' do
        subject.parse(cli_args:)
        expect(subject.options[:verbose]).to be true
      end

      it 'sets the yaml option to the specified file' do
        subject.parse(cli_args:)
        expect(subject.options[:yaml]).to eq('config.yaml')
      end
    end
  end
end
