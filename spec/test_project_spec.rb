require './spec/spec_helper'

describe TestProject do
  subject { TestProject.new }

  before do

  end

  it "does x" do
    expect(subject.bananas).to eq("bananas")
  end
end
