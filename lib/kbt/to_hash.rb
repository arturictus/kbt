module Kbt
  module ToHash
    extend Forwardable
    def_delegator :to_h, :[], :fetch
  end
end
