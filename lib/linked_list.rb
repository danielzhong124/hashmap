# frozen_string_literal: true

require_relative 'node'

class LinkedList
  def each
    curr = @head
    until curr.nil?
      yield curr
      curr = curr.next_node
    end
  end

  def append(key, value = nil)
    @head = Node.new(key, value, @head)
  end

  def size
    count = 0
    each { |_| count += 1 }

    count
  end

  def pop
    return nil if @head.nil?

    temp = @head
    @head = @head.next_node

    [temp.key, temp.value]
  end

  def contains?(key)
    each { |node| return true if node.key == key }
    false
  end

  def find(key)
    each { |node| return node if node.key == key }
    nil
  end

  def get(key)
    find(key)&.value
  end

  def update(key, value)
    entry = find(key)
    return nil if entry.nil?

    entry.value = value
    value
  end

  def remove(key)
    return nil if @head.nil?
    return pop[1] if @head.key == key

    prev = @head
    prev = prev.next_node until prev.next_node.nil? || prev.next_node.key == key

    temp = prev.next_node
    return nil if temp.nil?

    prev.next_node = temp.next_node
    temp.value
  end

  def to_s
    str = ''
    each { |node| str += "(#{node}) -> " }

    "#{str}nil"
  end

  private :find
end
