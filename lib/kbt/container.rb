module Kbt
  class Container
    attr_reader :template,
                :name,
                :image,
                :command,
                :env,
                :template_overrides

    def self.required_attributes
      [
        :name,
        :image,
        :env
      ]
    end

    def self.optional_attributes
      [
        :command,
        :ports,
        :volumeMounts,
        :livenessProbe,
        :readinessProbe,
        :resources,
        :lifecycle,
        # inherits_from
      ]
    end


    def initialize(args = {})
      @template = args.fetch(:template)
      @name = args.fetch(:name)
      @image = args.fetch(:image)
      @command = args.fetch(:command)
      @env = args.fetch(:env)
      # ports
      # volumeMounts
      # livenessProbe
      # readinessProbe
      # resources
      # lifecycle
      # inherits_from
      @template_overrides = args[:overrides] || {}
    end

    def to_h
      Fusu::Hash.deep_merge(
        template.value,
        overrides
      )
    end

    def overrides
      {
        "name"=> name,
        "image"=> image,
        "command" => command,
        "env" => env.to_h
      }.merge(template_overrides)
      # TODO add volumeMounts
    end

    def call
    end

  end
end
