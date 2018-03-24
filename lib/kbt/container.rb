module Kbt
  class Container
    attr_reader :template, :name, :image, :command
    def initialize(args = {})
      @template = args[:template]
      @name = args[:name]
      @image = args[:image]
      @command = args[:command]
      @env = args[:env]
    end

    def call
    end

  end
end
