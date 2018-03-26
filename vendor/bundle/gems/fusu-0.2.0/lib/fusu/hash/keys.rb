module Fusu
  module Hash
    module Keys
      # Returns a new hash with all keys converted using the block operation.
      #
      #  hash = { name: 'Rob', age: '28' }
      #
      #  Fusu::Hash.transform_keys(hash){ |key| key.to_s.upcase }
      #  # => {"NAME"=>"Rob", "AGE"=>"28"}
      def transform_keys(hash)
        return enum_for(:transform_keys, hash) unless block_given?
        result = ::Hash.new
        hash.each_key do |key|
          result[yield(key)] = hash[key]
        end
        result
      end

      # Destructively convert all keys using the block operations.
      # Same as transform_keys but modifies +self+.
      def transform_keys!(hash)
        return enum_for(:transform_keys!, hash) unless block_given?
        hash.keys.each do |key|
          hash[yield(key)] = hash.delete(key)
        end
        hash
      end

      # Returns a new hash with all keys converted to strings.
      #
      #   hash = { name: 'Rob', age: '28' }
      #
      #   Fusu::Hash.stringify_keys(hash)
      #   # => {"name"=>"Rob", "age"=>"28"}
      def stringify_keys(hash)
        transform_keys(hash){ |key| key.to_s }
      end

      # Destructively convert all keys to strings. Same as
      # +stringify_keys+, but modifies +self+.
      def stringify_keys!(hash)
        transform_keys!(hash){ |key| key.to_s }
      end

      # Returns a new hash with all keys converted to symbols, as long as
      # they respond to +to_sym+.
      #
      #   hash = { 'name' => 'Rob', 'age' => '28' }
      #
      #   Fusu::Hash.symbolize_keys(hash)
      #   # => {:name=>"Rob", :age=>"28"}
      def symbolize_keys(hash)
        transform_keys(hash){ |key| key.to_sym rescue key }
      end
      alias_method :to_options,  :symbolize_keys

      # Destructively convert all keys to symbols, as long as they respond
      # to +to_sym+. Same as +symbolize_keys+, but modifies +self+.
      def symbolize_keys!(hash)
        transform_keys!(hash){ |key| key.to_sym rescue key }
      end
      alias_method :to_options!, :symbolize_keys!

      # Returns a new hash with all keys converted by the block operation.
      # This includes the keys from the root hash and from all
      # nested hashes and arrays.
      #
      #  hash = { person: { name: 'Rob', age: '28' } }
      #
      #  Fusu::Hash.deep_transform_keys(hash){ |key| key.to_s.upcase }
      #  # => {"PERSON"=>{"NAME"=>"Rob", "AGE"=>"28"}}
      def deep_transform_keys(hash, &block)
        _deep_transform_keys_in_object(hash, &block)
      end

      # Destructively convert all keys by using the block operation.
      # This includes the keys from the root hash and from all
      # nested hashes and arrays.
      def deep_transform_keys!(hash, &block)
        _deep_transform_keys_in_object!(hash, &block)
      end

      # Returns a new hash with all keys converted to strings.
      # This includes the keys from the root hash and from all
      # nested hashes and arrays.
      #
      #   hash = { person: { name: 'Rob', age: '28' } }
      #
      #   Fusu::Hash.deep_stringify_keys(hash)
      #   # => {"person"=>{"name"=>"Rob", "age"=>"28"}}
      def deep_stringify_keys(hash)
        deep_transform_keys(hash){ |key| key.to_s }
      end

      # Destructively convert all keys to strings.
      # This includes the keys from the root hash and from all
      # nested hashes and arrays.
      def deep_stringify_keys!(hash)
        deep_transform_keys!(hash){ |key| key.to_s }
      end

      # Returns a new hash with all keys converted to symbols, as long as
      # they respond to +to_sym+. This includes the keys from the root hash
      # and from all nested hashes and arrays.
      #
      #   hash = { 'person' => { 'name' => 'Rob', 'age' => '28' } }
      #
      #   Fusu::Hash.deep_symbolize_keys(hash)
      #   # => {:person=>{:name=>"Rob", :age=>"28"}}
      def deep_symbolize_keys(hash)
        deep_transform_keys(hash){ |key| key.to_sym rescue key }
      end

      # Destructively convert all keys to symbols, as long as they respond
      # to +to_sym+. This includes the keys from the root hash and from all
      # nested hashes and arrays.
      def deep_symbolize_keys!(hash)
        deep_transform_keys!(hash){ |key| key.to_sym rescue key }
      end

      private
        # support methods for deep transforming nested hashes and arrays
        def _deep_transform_keys_in_object(object, &block)
          if object.class <= ::Hash
            object.each_with_object({}) do |(key, value), result|
              result[yield(key)] = _deep_transform_keys_in_object(value, &block)
            end
          elsif object.class <= ::Array
            object.map {|e| _deep_transform_keys_in_object(e, &block) }
          else
            object
          end
        end

        def _deep_transform_keys_in_object!(object, &block)
          if object.class <= ::Hash
            object.keys.each do |key|
              value = object.delete(key)
              object[yield(key)] = _deep_transform_keys_in_object!(value, &block)
            end
            object
          elsif object.class <= ::Array
            object.map! {|e| _deep_transform_keys_in_object!(e, &block)}
          else
            object
          end
        end
    end
  end
end
