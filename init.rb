if defined? Rails and Rails.env == 'test'
  Rails.configuration.after_initialize do
    require 'xml_fixtures'
  end
end
