require 'rover_game'

RSpec.describe InfinitePlane do
  describe '#rover_forward' do
    it 'moves the rover forward if there is nothing in the way' do
      subject = described_class.new(
        rover: Rover.new(position: [0, 0], direction: 'N'),
        obstacles: [Obstacle.new(position: [0, 2])]
      )

      expect { subject.rover_forward }.to change { subject.rover.position }.from([0, 0]).to([0, 1])
    end

    it "doesn't move the rover forward if there's something in the way" do
      subject = described_class.new(
        rover: Rover.new(position: [0, 0], direction: 'N'),
        obstacles: [Obstacle.new(position: [0, 1])]
      )

      expect { subject.rover_forward }.not_to change { subject.rover.position }.from([0, 0])
    end
  end
end
