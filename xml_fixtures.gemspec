# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name                      = "xml_fixtures"
  s.version                   = "0.1.1"
  s.authors                   = ["QualitySmith Inc."]
  s.date                      = "2010-07-29"
  s.email                     = "info@QualitySmith.com"
  s.homepage                  = "http://www.github.com/qualitysmith/xml_fixtures"
  s.rubyforge_project         = "none"
  s.rdoc_options              = ["--charset=UTF-8"]
  s.platform                  = Gem::Platform::RUBY
  s.summary                   = "Adds support for XML fixtures in tests."
  s.description               = "This gem provides your tests with the ability to load XML from fixture files and compare two XML documents using REXML."
  s.required_rubygems_version = ">= 1.3.6"
  s.require_paths             = ["lib"]
  s.files                     = Dir.glob("{bin,lib,test}/**/*") + %w{MIT-LICENSE Rakefile README}
  s.test_files                = Dir.glob("test/**/*")
end
