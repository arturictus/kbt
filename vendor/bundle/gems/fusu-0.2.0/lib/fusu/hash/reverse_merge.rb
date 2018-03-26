module Fusu
  module Hash
    module ReverseMerge
      # Merges the caller into +other_hash+. For example,
      #
      #   options = Fusu::Hash.reverse_merge(options, {size: 25, velocity: 10})
      #
      # is equivalent to
      #
      #   options = { size: 25, velocity: 10 }.merge(options)
      #
      # This is particularly useful for initializing an options hash
      # with default values.
      def reverse_merge(hash, other_hash)
        other_hash.merge(hash)
      end

      # Destructive +reverse_merge+.
      def reverse_merge!(hash, other_hash)
        # right wins if there is no left
        hash.merge!( other_hash ){|key,left,right| left }
      end
      alias_method :reverse_update, :reverse_merge!
    end
  end
end
