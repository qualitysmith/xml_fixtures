# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name        = "xml_fixtures"
  s.version     = "0.0.1"
  s.author      = "Michael Goff"
  s.email       = "Michael.Goff@QualitySmith.com"
  s.homepage    = ""
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Extends Rails to support simple xml fixtures for testing and asserts for working with them."
  s.description = "Extends Rails to support simple xml fixtures for testing and asserts for working with them."
  s.required_rubygems_version = ">= 1.3.6"
  s.require_path = "lib"
  s.files       = Dir.glob("{bin,lib}/**/*") + %w{README MIT-LICENSE}
end
