require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
    s.name       = "xml_fixtures"
    s.version    = "0.0.1"
    s.author     = "Michael Goff"
    s.email      = "Michael.Goff@QualitySmith.com"
    s.homepage   = ""
    s.platform   = Gem::Platform::RUBY
    s.summary    = "Extends Rails to support simple xml fixtures for testing and asserts for working with them."
    s.files      = FileList["{lib,test}/**/*"].exclude("rdoc").to_a
    s.require_path      = "lib"
    s.test_file         = "test/test_helper.rb"
    s.has_rdoc          = true
    s.extra_rdoc_files  = ['README']
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
end


desc 'Default: run unit tests.'
task :default => :test

desc 'Test the xml_fixtures plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the xml_fixtures plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'XmlFixtures'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
