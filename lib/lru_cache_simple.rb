class LruCacheSimple
  attr_reader :max_size

  def initialize(max_size)
    @max_size = max_size
    @cache = {}
    @key_index = []
  end

  def get(key)
    return nil unless @key_index.include?(key)

    # Move the key to the front of the index
    pop_to_front(key)

    # Return the actual value
    @cache[key]
  end

  def set!(key, value)
    # If the key exists already, update the value and move the key to the front
    if @key_index.include?(key)
      pop_to_front(key)
      @cache[key] = value
      return true

    else
      # If the cache is full, remove the least recently used key
      @cache.delete(@key_index.shift) if @cache.size >= @max_size

      # Add the key to the cache and pop the key to the front of the index
      @cache[key] = value
      @key_index.unshift(key)

      return true
    end
  end

  private

  def pop_to_front(key)
    # TODO: Gate against nils
    # Pop the key onto the front of the index
    @key_index.delete(key)
    @key_index.unshift(key)
  end
end
