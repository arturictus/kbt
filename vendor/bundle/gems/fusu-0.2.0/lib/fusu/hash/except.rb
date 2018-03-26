module Fusu
  module Hash
    module Except
      # Returns a hash that includes everything but the given keys.
      #   hash = { a: true, b: false, c: nil}
      #   Fusu::Hash.except(hash, :c) # => { a: true, b: false}
      #   hash # => { a: true, b: false, c: nil}
      #
      # This is useful for limiting a set of parameters to everything but a few known toggles:
      #   @person.update(Fusu::Hash.except(params[:person], :admin))
      def except(hash, *keys)
        except!(hash.dup, *keys)
      end

      # Replaces the hash without the given keys.
      #   hash = { a: true, b: false, c: nil}
      #   Fusu::Hash.except!(hash, :c) # => { a: true, b: false}
      #   hash # => { a: true, b: false }
      def except!(hash, *keys)
        keys.each { |key| hash.delete(key) }
        hash
      end
    end
  end
end
