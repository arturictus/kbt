require 'yaml'
module Kbt
  class Template
    attr_reader :file, :key
    def initialize(file, key, opts = {})
      @file = file
      @key = key
    end

    def yml
      Fusu::HashWithIndifferentAccess.new(YAML.load(file))
    end

    def keys
      key.split('.')
    end

    def value
      keys.inject(yml) do |prev, nxt|

      end
    end

    def call
    end
  end
end
