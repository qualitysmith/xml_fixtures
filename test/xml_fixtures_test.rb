require 'test_helper'

class XmlFixturesTest < Test::Unit::TestCase
  context 'get_xml_fixture' do
    should 'raise when nonsense filename' do
      assert_raise( Errno::ENOENT ) {
        get_xml_fixture('blahblahnonsense')
      }
    end

    should 'load file and run through erb' do
      assert_equal "<test>\n  example\n</test>\n", get_xml_fixture('xml_with_erb.xml')
    end
  end

  context "assert_xml_equal" do
    should 'fail if not equal' do
      assert_raise( Test::Unit::AssertionFailedError ) {
        assert_xml_equal :xml_with_erb, '<something>very different</something>'
      }
    end

    should 'have nice message on fail' do
      begin
        assert_xml_equal :xml_with_erb, '<something>very different</something>'
      rescue Exception => e
        assert_equal "<test>\n  example\n</test>\n expected but was\n<something>very different</something>", e.message
      end
    end

    should 'pass if equal' do
      assert_nothing_raised {
        assert_xml_equal :xml_with_erb, '<test>example</test>'
      }
    end
  end

  protected

  def xml_fixture_path
    File.join( File.dirname(__FILE__), 'fixtures' )
  end
end
