module XmlFixtures
  def get_xml_fixture(filename)
    fixture_xml = ''
    File.open(xml_fixture_path + filename) do |f|
      fixture_xml = f.read
    end
    return ERB.new(fixture_xml).result
  end

  def assert_xml_equal(first, second)
    first = get_xml_fixture(first.to_s + '.xml') if first.is_a? Symbol
    assert_block("#{first.to_s} expected but was\n#{second.to_s}") do
      REXML::Document.new(first) == REXML::Document.new(second)
    end
  end

  protected

  def xml_fixture_path
    'test/fixtures/xml/'
  end
end
