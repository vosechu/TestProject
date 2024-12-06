# frozen_string_literal: true

# Here’s a quick warmup problem for you, Chuck:
#
# Problem: Two Sum
#
# Given an array of integers nums and an integer target, return the indices of the
# two numbers that add up to target.
#
# Example:
#
# Input: nums = [2, 7, 11, 15], target = 9
# Output: [0, 1]
# Explanation: nums[0] + nums[1] == 9, so return [0, 1].
#
# Constraints:
# 	1.	Each input has exactly one solution.
# 	2.	You may not use the same element twice.
#
# Follow-up:
# Try to solve it with an optimal solution that runs in O(n) time complexity.

require 'contracts'

class TwoSum
  include Contracts::Core
  include Contracts::Builtin

  Contract KeywordArgs[nums: ArrayOf[Num], target: Num] => Any
  def initialize(nums:, target:)
    raise ArgumentError if nums.empty?
    raise ArgumentError if nums.length < 2
    raise ArgumentError if target.zero?

    @nums = nums
    @target = target
  end

  Contract None => Or[ArrayOf[Num], false]
  def call
    @nums.each_with_index do |num_outer, idx_outer|
      @nums.each_with_index do |num_inner, idx_inner|
        next if num_outer == num_inner

        return [idx_outer, idx_inner] if num_outer + num_inner == @target
      end
    end
    false
  end

  # # O(n) version, but I find it inscrutible
  # def call_order_n
  #   @nums.each_with_index do |num_outer, idx_outer|
  #     observed = {}
  #     @nums.each_with_index do |num, idx|
  #       return [observed[@target - num], idx] if observed[@target - num]

  #       observed[num] = idx
  #     end
  #   end
  #   false
  # end
end
