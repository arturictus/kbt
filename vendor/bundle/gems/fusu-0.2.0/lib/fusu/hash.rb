require 'fusu/hash/except'
require 'fusu/hash/keys'
require 'fusu/hash/reverse_merge'
require 'fusu/hash/deep_merge'
module Fusu
  module Hash
    extend Except
    extend Keys
    extend ReverseMerge
    extend DeepMerge
  end
end
