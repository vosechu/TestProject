# frozen_string_literal: true

class DoublyLinkedList
  include Enumerable

  class Node
    attr_accessor :value, :prev, :next

    def initialize(value)
      @value = value
      @prev = nil
      @next = nil
    end
  end

  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def each(&block)
    current_node = @head
    while current_node
      block.call(current_node)
      current_node = current_node.next
    end
  end

  def <=>(other)
    nil unless other.is_a?(DoublyLinkedList)

    # TODO: compare each element
    # @items <=> other.items
  end

  def shift(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      @tail.next = new_node
      new_node.prev = @tail
    end
    @tail = new_node
  end

  def unshift(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.next = @head
      @head.prev = new_node
      @head = new_node
    end
  end
end
