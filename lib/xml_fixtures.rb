require 'rexml/document'
require 'try' if !defined?(try)
require 'rexml_overrides'
require 'xml_fixture_helper'
require 'erb'
Test::Unit::TestCase.send :include, XmlFixtureHelper
