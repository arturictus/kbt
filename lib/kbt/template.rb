require 'yaml'
module Kbt
  class Template
    attr_reader :file_path, :key
    def initialize(file_path, key = nil)
      @file_path = file_path.to_s =~ /.yml$/ ? file_path : "#{file_path}.yml"
      @key = key
    end

    def yml
      @yml ||= YAML.load(file_content)
    end

    def file_content
      @file_content ||= File.read(file_path)
    end

    def keys
      key ? key.split('.') : nil
    end

    def value
      return yml unless keys
      keys.inject(yml) do |prev, nxt|
        prev[nxt]
      end
    end
  end
end
