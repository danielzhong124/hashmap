# frozen_string_literal: true

require_relative 'linked_list'

class HashSet
  def initialize(capacity = 16, load_factor = 0.75)
    @buckets = Array.new(capacity) { LinkedList.new }
    @load_factor = load_factor
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % capacity
  end

  def set(key)
    bucket = @buckets[hash(key)]
    return if bucket.contains?(key)

    bucket.append(key)
    grow_buckets if length > capacity * @load_factor
  end

  def has?(key)
    @buckets[hash(key)].contains?(key)
  end

  def remove(key)
    @buckets[hash(key)].remove(key)
  end

  def length
    count = 0
    @buckets.each { |bucket| count += bucket.size }

    count
  end

  def clear
    @buckets.map! { |_| LinkedList.new }
  end

  def keys
    result = []
    @buckets.each do |bucket|
      bucket.each { |entry| result << entry.key }
    end

    result
  end

  def grow_buckets
    all_keys = keys
    @buckets = Array.new(capacity * 2) { LinkedList.new }

    all_keys.each { |key| @buckets[hash(key)].append(key) }
  end

  def capacity
    @buckets.length
  end

  private :grow_buckets
end
