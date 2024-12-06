# frozen_string_literal: true

require './spec/spec_helper'
require 'bank_teller/bank_teller'
require 'csv'

RSpec.describe BankTeller do
  subject { described_class.new }

  it 'takes a csv' do
    balance_sheet = <<~EOF
      1,Alice,deposit,10
      2,Bob,deposit,20
      3,Alice,deposit,20
      4,Bob,withdraw,5
      5,Alice,withdraw,10
    EOF

    valid_balance_sheet = CSV.parse(balance_sheet)
    expect(subject.import(balance_sheet: valid_balance_sheet)).to eql({
      'Alice' => 20,
      'Bob' => 15
    })
  end

  it 'facilitates transfers' do
    balance_sheet = <<~EOF
      1,Alice,deposit,10
      2,Bob,deposit,20
      3,Alice,transfer,Bob,5
    EOF

    valid_balance_sheet = CSV.parse(balance_sheet)
    expect(subject.import(balance_sheet: valid_balance_sheet)).to eql({
      'Alice' => 5,
      'Bob' => 25
    })
  end

  it 'supports querying account balances in the past' do
    # Alice’s balance at t=1 is 10
    # Alice’s balance at t=2 is 10
    # Alice’s balance at t=3 is 5
    # Bob’s balance at t=1 is 0
    # Bob’s balance at t=2 is 20
    # Bob’s balance at t=3 is 25

    balance_sheet = <<~EOF
      1,Alice,deposit,10
      2,Bob,deposit,20
      3,Alice,transfer,Bob,5
    EOF

    valid_balance_sheet = CSV.parse(balance_sheet)
    subject.import(balance_sheet: valid_balance_sheet)
    expect(subject.history).to eql([
      { 'Alice' => 10 },
      { 'Alice' => 10, 'Bob' => 20 },
      { 'Alice' => 5, 'Bob' => 25 }
    ])
  end
end
