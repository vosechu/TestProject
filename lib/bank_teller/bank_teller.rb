# frozen_string_literal: true

class BankTeller
  def initialize
    @accounts = Hash.new(0)
    @account_history = []
  end

  def import(balance_sheet:)
    balance_sheet.map do |transaction|
      transaction[0].to_i
      account_name = transaction[1]
      action = transaction[2]

      if %w[deposit withdraw].include?(transaction[2])
        amount = transaction[3]

        @accounts[account_name] += amount.to_i if action == 'deposit'
        @accounts[account_name] -= amount.to_i if action == 'withdraw'
      elsif transaction[2] == 'transfer'
        target_account = transaction[3]
        amount = transaction[4]

        @accounts[account_name] -= amount.to_i
        @accounts[target_account] += amount.to_i
      end
      @account_history << @accounts.dup
    end

    @accounts
  end

  def history
    @account_history.each_with_index do |item, idx|
      item.map do |state|
        puts "#{state[0]}'s balance at t=#{idx} is #{state[1]}"
      end
    end
  end
end
