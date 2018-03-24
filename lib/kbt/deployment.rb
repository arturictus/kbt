module Kbt
  class Deployment
    attr_reader :template, :containers, :replicas, :name, :labels
    def initialize(args = {})
      @template = args[:template]
      @name = args[:name]
      @labels = args[:labels]
      @containers = args[:containers]
      @replicas = args[:replicas] || 1
    end


    def call
    end

  end
end
