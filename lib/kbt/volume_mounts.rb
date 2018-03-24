module Kbt
  class VolumeMounts
    attr_reader :template, :name, :image, :command, :env
    def initialize(args = {})
      @template = args.fetch(:template)
    end

    def to_h
      template.value
    end
  end
end
