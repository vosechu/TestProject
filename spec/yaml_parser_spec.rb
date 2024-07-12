# frozen_string_literal: true

require 'yaml_parser'

RSpec.describe YamlParser do
  describe '#parse' do
    context 'when given valid YAML' do
      before do
        allow(File).to receive(:read).and_call_original
        allow(YAML).to receive(:safe_load).and_call_original
      end

      it 'returns a hash of the YAML file contents' do
        yaml_file = 'spec/fixtures/valid.yml'
        subject = described_class.new(file: yaml_file)
        expect(subject.parse.keys).to eq(%w[server logging])
        expect(File).to have_received(:read).with(yaml_file)
      end

      it 'returns a hash when given a string' do
        yaml_string = <<~YAML
          server:
            host: localhost
            port: 8080
          logging:
            level: debug
        YAML
        subject = described_class.new(string: yaml_string)
        expect(subject.parse.keys).to eq(%w[server logging])
        expect(YAML).to have_received(:safe_load).with(yaml_string)
      end
    end

    context 'when given an invalid YAML file' do
      it 'raises an error' do
        yaml_file = 'spec/fixtures/invalid.yml'
        subject = described_class.new(file: yaml_file)

        expect { subject.parse }.to raise_error(Psych::SyntaxError)
      end
    end

    it 'understands scalars' do
      yaml = <<~YAML
        bananagrams
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to eq('bananagrams')
    end

    it 'understands comments' do
      yaml = <<~YAML
        bananagrams # This is a comment
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to eq('bananagrams')
    end

    it 'understands sequences of scalars' do
      yaml = <<~YAML
        - bananas
        - apples
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to eq(%w[bananas apples])
    end

    it 'understands basic mappings (aka objects) (scalar to scalar)' do
      yaml = <<~YAML
        bananas: yellow
        apples: red
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to match('bananas' => 'yellow', 'apples' => 'red')
    end

    it 'understands mappings of sequences' do
      yaml = <<~YAML
        bananas:
        - Nam wah
        - Lady Finger
        - Cavendish
        apples:
        - Honeycrisp
        - Granny Smith
        - Fuji
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to match('bananas' => ['Nam wah', 'Lady Finger', 'Cavendish'],
                                     'apples' => ['Honeycrisp', 'Granny Smith', 'Fuji'])
    end

    it 'understands mappings of mappings' do
      yaml = <<~YAML
        bananas:
          Nam wah: 1
          Lady Finger: 2
          Cavendish: 3
        apples:
          Honeycrisp: 1
          Granny Smith: 2
          Fuji: 3
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to match('bananas' => { 'Nam wah' => 1, 'Lady Finger' => 2, 'Cavendish' => 3 },
                                     'apples' => { 'Honeycrisp' => 1, 'Granny Smith' => 2, 'Fuji' => 3 })
    end

    it 'understands sequences of mappings' do
      yaml = <<~YAML
        -
            Nam wah: 1
            Lady Finger: 2
            Cavendish: 3
        -
            Honeycrisp: 1
            Granny Smith: 2
            Fuji: 3
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to eq([{ 'Nam wah' => 1, 'Lady Finger' => 2, 'Cavendish' => 3 },
                                   { 'Honeycrisp' => 1, 'Granny Smith' => 2, 'Fuji' => 3 }])
    end

    it 'understands sequences of sequences' do
      yaml = <<~YAML
        -
          - fruit
          - number
          - shape
        -
          - apple
          - 1
          - round
        -
          - banana
          - 2
          - curved
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to eq([%w[fruit number shape], ['apple', 1, 'round'], ['banana', 2, 'curved']])
    end

    it 'understands sequences of sequences using the [] syntax' do
      yaml = <<~YAML
        - [fruit, number, shape]
        - [apple, 1, round]
        - [banana, 2, curved]
      YAML
      subject = described_class.new(string: yaml)
      expect(subject.parse).to eq([%w[fruit number shape], ['apple', 1, 'round'], ['banana', 2, 'curved']])
    end
  end
end
