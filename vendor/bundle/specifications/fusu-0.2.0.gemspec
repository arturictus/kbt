# -*- encoding: utf-8 -*-
# stub: fusu 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fusu".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Artur Panyach".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-11-02"
  s.description = "Functional support".freeze
  s.email = ["arturictus@gmail.com".freeze]
  s.homepage = "https://github.com/arturictus/fusu".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.2".freeze
  s.summary = "Functional support".freeze

  s.installed_by_version = "2.5.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
