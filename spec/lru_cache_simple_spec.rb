require 'lru_cache_simple'

RSpec.describe LruCacheSimple do
  subject { described_class.new(2) }

  describe '#get' do
    context 'when the key exists in the cache' do
      it 'returns the value associated with the key' do
        subject.set!('key1', 'value1')
        subject.set!('key2', 'value2')
        expect(subject.get('key1')).to eq('value1')
      end

      it 'moves the key to the front of the index' do
        subject.set!('key1', 'value1')
        subject.set!('key2', 'value2')
        expect(subject.instance_variable_get(:@key_index)).to eq(%w[key2 key1])
        subject.get('key1')
        expect(subject.instance_variable_get(:@key_index)).to eq(%w[key1 key2])
      end
    end

    context 'when the key does not exist in the cache' do
      it 'returns nil' do
        expect(subject.get('nonexistent_key')).to be_nil
      end
    end
  end

  describe '#set!' do
    context 'when the key already exists in the cache' do
      it 'updates the value associated with the key' do
        subject.set!('key1', 'value1')
        subject.set!('key1', 'new_value')
        expect(subject.get('key1')).to eq('new_value')
      end

      it 'moves the key to the front of the index' do
        subject.set!('key1', 'value1')
        subject.set!('key2', 'value2')
        subject.set!('key1', 'new_value')
        expect(subject.instance_variable_get(:@key_index)).to eq(%w[key1 key2])
      end
    end

    context 'when the cache is full' do
      it 'removes the least recently used key' do
        cache = described_class.new(2)
        cache.set!('key1', 'value1')
        cache.set!('key2', 'value2')
        cache.set!('key3', 'value3') # This is one too many for the max_size
        expect(subject.get('key1')).to be_nil
      end
    end
  end
end
