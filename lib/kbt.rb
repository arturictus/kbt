require "kbt/version"
require 'fusu'

module Kbt
  def self.templates_folder
    File.expand_path('../templates', __dir__)
  end

  def root
    Pathname.new(File.expand_path('../lib', __FILE__))
  end
end

require 'kbt/environment'
require 'kbt/template'
require 'kbt/container'
require 'kbt/deployment'
