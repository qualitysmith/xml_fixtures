if defined? Rails and Rails.env == 'test'
  Rails.configuration.after_initialize do
    require 'test_help'
    require 'rexml/document'
    require 'rexml_overrides'
    ActiveSupport::TestCase.send :include, XmlFixtures
  end
end
