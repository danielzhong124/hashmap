# frozen_string_literal: true

class Node
  attr_reader :key
  attr_accessor :value, :next_node

  def initialize(key, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end

  def to_s
    "#{@key}#{@value.nil? ? '' : ", #{@value}"}"
  end
end
