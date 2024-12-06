# frozen_string_literal: true

require 'rover_game/rover'

RSpec.describe Rover do
  # subject { described_class.new }

  describe '#left' do
    it 'changes the direction to the left' do
      subject = described_class.new(direction: 'N')
      expect { subject.left }.to change { subject.direction }.from('N').to('W')
    end
  end

  describe '#right' do
    it 'changes the direction to the right' do
      subject = described_class.new(direction: 'N')
      expect { subject.right }.to change { subject.direction }.from('N').to('E')
    end
  end

  describe '#forward' do
    it 'moves the rover forward' do
      subject = described_class.new(position: [0, 0], direction: 'N')
      expect { subject.forward }.to change { subject.position }.from([0, 0]).to([0, 1])
    end
  end
end
