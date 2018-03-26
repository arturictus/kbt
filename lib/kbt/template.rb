require 'yaml'
module Kbt
  class Template
    attr_reader :file_path, :key
    def initialize(file_path, key = nil)
      @file_path = get_file_path(file_path)
      @key = key
    end

    def value
      check_file!
      check_yaml!
      return yml unless keys
      keys.inject(yml) do |prev, nxt|
        if prev.respond_to?(:[]); prev[nxt]
        else raise WrongKey, "for file: #{file_path} with key: #{key}"
        end
      end
    end
    alias_method :to_h, :value

    def file_exists?
      File.exists?(file_path)
    end

    def key_exists?
      value.class <= Hash
    rescue WrongKey
      false
    end

    def valid_yaml?
      check_yaml!
      true
    rescue NotValidYaml
      false
    end

    def exists?
      validate!
    rescue *self.class.errors
      false
    end
    alias_method :valid?, :exists?

    def validate!
      file_exists? && valid_yaml? && key_exists?
    end

    private

    def check_file!
      raise WrongFile, "File does not exists at: #{file_path}" unless file_exists?
    end

    def check_yaml!
      if yml.class <= Hash; true
      else raise NotValidYaml, "Not valid YAML at #{file_path}"
      end
    rescue
      raise NotValidYaml, "Not valid YAML at #{file_path}"
    end

    def get_file_path(file_path)
      file_path.to_s =~ /.yml$/ ? file_path : "#{file_path}.yml"
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
    class WrongKey < StandardError; end
    class WrongFile < StandardError; end
    class WrongValue < StandardError; end
    class NotValidYaml < StandardError; end

    def self.errors
      [
        WrongKey,
        WrongFile,
        WrongValue,
        NotValidYaml
      ]
    end
  end
end
