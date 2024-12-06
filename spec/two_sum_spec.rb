# frozen_string_literal: true

require './spec/spec_helper'
require 'two_sum'

RSpec.describe TwoSum do
  subject { described_class.new(nums: valid_nums, target: valid_target) }

  let(:valid_nums) { [1, 2, 3] }
  let(:valid_target) { 5 }

  it 'returns an array of the two indices needed to add up to the target' do
    expect(described_class.new(nums: valid_nums, target: 3).call).to eql([0, 1])
    expect(described_class.new(nums: valid_nums, target: 4).call).to eql([0, 2])
    expect(described_class.new(nums: valid_nums, target: 5).call).to eql([1, 2])
    expect(described_class.new(nums: [1, 2, 3, 4, 5, 6, 7, 8, 9, 16], target: 15).call).to eql([5, 8])
    # call_order_n processes differently, so this is the result, but it's valid either way
    # expect(described_class.new(nums: [1, 2, 3, 4, 5, 6, 7, 8, 9, 16], target: 15).call).to eql([6, 7])
    expect(described_class.new(nums: [1, 2, 3, 4, 5, 6, 7, 8, 9, 16], target: 20).call).to eql([3, 9])
    expect(described_class.new(nums: [1, 2, 3, 4, 5, 6, 7, 8, 9, 16], target: 25).call).to eql([8, 9])
    expect(described_class.new(nums: [1, 2, 3, 4, 5, 6, 7, 8, 9, 14, 16], target: 30).call).to eql([9, 10])
  end

  it 'handles out of order numbers gracefully' do
    expect(described_class.new(nums: valid_nums.reverse, target: 5).call).to eql([0, 1])
  end

  it 'returns false if no match is found' do
    expect(described_class.new(nums: valid_nums, target: 1_000_000).call).to be_falsey
  end

  context 'when the inputs are invalid' do
    it 'raises an exception if the nums array is nil' do
      expect {
        _subject = described_class.new(nums: nil, target: valid_target)
      }.to raise_exception(ParamContractError)
    end

    it 'raises an exception if the nums array is empty' do
      expect {
        _subject = described_class.new(nums: [], target: valid_target)
      }.to raise_exception(ArgumentError)
    end

    it 'raises an exception if the nums array only contains one number' do
      expect {
        _subject = described_class.new(nums: [1], target: valid_target)
      }.to raise_exception(ArgumentError)
    end

    it 'raises an exception if the nums array contains non-numeric values' do
      expect {
        _subject = described_class.new(nums: ['a', 1, 2, 3], target: valid_target)
      }.to raise_exception(ParamContractError)
    end

    it 'raises an exception if the target is missing' do
      expect {
        _subject = described_class.new(nums: valid_nums, target: nil)
      }.to raise_exception(ParamContractError)
    end

    it 'raises an exception if the target is 0' do
      expect {
        _subject = described_class.new(nums: valid_nums, target: 0)
      }.to raise_exception(ArgumentError)
    end

    it 'raises an exception if the target is not a number' do
      expect {
        _subject = described_class.new(nums: valid_nums, target: 'a')
      }.to raise_exception(ParamContractError)
    end
  end
end
