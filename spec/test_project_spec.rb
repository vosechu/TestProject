# frozen_string_literal: true

require './spec/spec_helper'

describe TestProject do
  subject { described_class.new }

  it 'does x' do
    expect(subject.bananas).to eq('bananas')
  end
end
