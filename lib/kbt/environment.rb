module Kbt
  class Environment
    attr_reader :template, :overrides
    def initialize(args = {})
      @template = args[:template]
      @overrides = args[:overrides]
    end
    def call
    end
  end
end
