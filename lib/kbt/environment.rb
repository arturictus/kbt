module Kbt
  class Environment
    attr_reader :template, :overrides
    def initialize(template, overrides = {})
      @template = template
      @overrides = overrides
    end

    def to_h
      template.value
        .reject { |e| override_keys.include?(e["name"]) }
        .concat(format_overrides)
    end

    def override_keys
      overrides.keys.map(&:to_s)
    end

    def format_overrides
      overrides.map do |k, v|
        { 'name' => k.to_s,
          'value' => v.to_s }
      end
    end


  end
end
