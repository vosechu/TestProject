# require 'doubly_linked_list'

# RSpec.describe DoublyLinkedList do
#   subject { described_class.new }

#   describe '#initialize' do
#     it 'creates an empty list' do
#       expect(subject).to be_empty
#     end
#   end

#   describe '#each' do
#     it 'iterates over each element in the list' do
#       subject.unshift(1)
#       subject.unshift(2)
#       subject.unshift(3)

#       result = []
#       subject.each { |node| result << node.value }

#       expect(result).to eq([3, 2, 1])
#     end
#   end

#   describe '#<=>' do
#     it 'compares the size of two lists' do
#       subject1 = DoublyLinkedList.new
#       subject2 = DoublyLinkedList.new

#       subject1.unshift(1)
#       subject1.unshift(2)
#       subject2.unshift(3)

#       expect(subject1 <=> subject2).to eq(-1)
#     end
#   end

#   describe '#shift' do
#     it 'adds a new node to the end of the list' do
#       subject.shift(1)
#       subject.shift(2)

#       expect(subject.to_a).to eq([1, 2])
#     end
#   end

#   describe '#unshift' do
#     it 'adds a new node to the beginning of the list' do
#       subject.unshift(1)
#       subject.unshift(2)

#       expect(subject.to_a).to eq([2, 1])
#     end
#   end
# end
