require 'yaml'
module Kbt
  class Template
    attr_reader :file_path, :key
    def initialize(file_path, key, opts = {})
      @file_path = file_path.to_s =~ /.yml$/ ? file_path : "#{file_path}.yml"
      @key = key
    end

    def yml
      @yml ||= YAML.load(content)
    end

    def content
      @content ||= File.read(file_path)
    end


    def keys
      key.split('.')
    end

    def value
      keys.inject(yml) do |prev, nxt|
        prev[nxt]
      end
    end

    def call
    end
  end
end
