require 'test_helper'

class RexmlOverridesTest < ActiveSupport::TestCase
  context 'get_child_list' do
    should "be empty" do
      root = REXML::Document.new('<root></root>').elements.first
      assert_equal([], root.send(:get_child_list, root) )
    end

    should "raise if to children of the same name" do
      root = REXML::Document.new('<root><child1></child1><child2></child2><child1></child1></root>').elements.first
      assert_raise( RuntimeError ) {
        root.send(:get_child_list, root)
      }
    end

    should "get simple set" do
      root = REXML::Document.new('<root><child1>child 1 content</child1><child2>child 2 content</child2></root>').elements.first
      set = root.send(:get_child_list, root)
      assert_equal 2, set.size
      assert set.any? {|element| element.name = 'child1' }
      assert set.any? {|element| element.name = 'child2' }
    end
  end

  context 'set_children_equal?' do
    should 'return true with no children' do
      xml1 = REXML::Document.new('<root></root>').root
      xml2 = REXML::Document.new('<root></root>').root
      assert xml1.send(:set_children_equal?, xml2)
    end

    should 'return false if one has a child element and the other none' do
      xml1 = REXML::Document.new('<root><cool>test</cool></root>').root
      xml2 = REXML::Document.new('<root></root>').root
      assert !xml1.send(:set_children_equal?, xml2)
    end

    should 'return true if both have equal child element' do
      xml1 = REXML::Document.new('<root><cool>test</cool></root>').root
      xml2 = REXML::Document.new('<root><cool>test</cool></root>').root
      assert xml1.send(:set_children_equal?, xml2)
    end

    should 'return false when they have an equal elemnt and an element with a different name' do
      xml1 = REXML::Document.new('<root><cool>test</cool><neat>oh</neat></root>').root
      xml2 = REXML::Document.new('<root><cool>test</cool><wow>oh</wow></root>').root
      assert !xml1.send(:set_children_equal?, xml2)
    end

    should 'return true when equal nested tags but with whitespace' do
      xml1 = REXML::Document.new('<root><cool><test>awesome</test></cool><neat>oh</neat></root>').root
      xml2 = REXML::Document.new("<root>\n\n\t \t\n<cool><test>awesome</test></cool><neat>oh</neat></root>").root
      assert xml1.send(:set_children_equal?, xml2)
    end

    should 'return true when equal elements but out of order' do
      xml1 = REXML::Document.new('<root><cool><test>awesome</test></cool><neat>oh</neat></root>').root
      xml2 = REXML::Document.new('<root><neat>oh</neat><cool><test>awesome</test></cool></root>').root
      assert xml1.send(:set_children_equal?, xml2)
    end
  end

  context 'children_look_like_an_array?' do
    should 'return true if only one element' do
      xml = REXML::Document.new('<root><test>cool</test></root>').root
      assert xml.send(:children_look_like_an_array?)
    end

    should 'return true if all elements have the same name' do
      xml = REXML::Document.new('<root><test>cool</test><test>again</test></root>').root
      assert xml.send(:children_look_like_an_array?)
    end

    should 'return false if any element has a different name' do
      xml = REXML::Document.new('<root><test>cool</test><wow>uh oh</wow><test>again</test></root>').root
      assert !xml.send(:children_look_like_an_array?)
    end
  end

  context 'array_children_equal?' do
    should 'return true for single equal elements' do
      xml1 = REXML::Document.new('<root><test>cool</test></root>').root
      xml2 = REXML::Document.new("<root>\n\t<test>cool</test>\n</root> ").root
      assert xml1.send(:array_children_equal?, xml2)
    end

    should 'return false for single different elements' do
      xml1 = REXML::Document.new('<root><test>cool</test></root>').root
      xml2 = REXML::Document.new("<root><test>cooler</test>\n</root> ").root
      assert !xml1.send(:array_children_equal?, xml2)
    end

    should 'return true for equal elements and in order' do
      xml1 = REXML::Document.new('<root><test>cool</test><another>yeah</another></root>').root
      xml2 = REXML::Document.new('<root><test>cool</test><another>yeah</another></root> ').root
      assert xml1.send(:array_children_equal?, xml2)
    end

    should 'return false for equal elements but out of order' do
      xml1 = REXML::Document.new('<root><test>cool</test><another>yeah</another></root>').root
      xml2 = REXML::Document.new('<root><another>yeah</another><test>cool</test></root> ').root
      assert !xml1.send(:array_children_equal?, xml2)
    end
  end

  context 'child_elements_equal?' do
    should "return false when element count is different" do
      xml1 = REXML::Document.new('<root><another>yeah</another></root>').root
      xml2 = REXML::Document.new('<root><test>cool</test><another>yeah</another></root>').root
      assert !xml1.send(:child_elements_equal?, xml2)
    end

    should 'return true if there are no elements' do
      xml1 = REXML::Document.new('<root></root>').root
      xml2 = REXML::Document.new('<root></root>').root
      assert xml1.send(:child_elements_equal?, xml2)
    end

    should 'return true for simple array' do
      xml1 = REXML::Document.new('<root><test>cool</test><test>yeah</test></root>').root
      xml2 = REXML::Document.new('<root><test>cool</test><test>yeah</test></root>').root
      assert xml1.send(:child_elements_equal?, xml2)
    end

    should 'return false for simple array' do
      xml1 = REXML::Document.new('<root><test>cool</test><test>yeah</test></root>').root
      xml2 = REXML::Document.new('<root><test>cool</test><test>no</test></root>').root
      assert !xml1.send(:child_elements_equal?, xml2)
    end

    should 'return true for simple set' do
      xml1 = REXML::Document.new('<root><another>yeah</another><test>cool</test></root>').root
      xml2 = REXML::Document.new('<root><test>cool</test><another>yeah</another></root>').root
      assert xml1.send(:child_elements_equal?, xml2)
    end

    should 'return false for simple set' do
      xml1 = REXML::Document.new('<root><another>yeah</another><test>cool</test></root>').root
      xml2 = REXML::Document.new('<root><test>cool</test><another>no</another></root>').root
      assert !xml1.send(:child_elements_equal?, xml2)
    end
  end

  context 'element ==' do
    should 'be false when not comparing with an element' do
      xml = REXML::Document.new('<root></root>').root
      assert_not_equal xml, 'test'
    end

    should 'be false when names of tags not the same' do
      xml1 = REXML::Document.new('<root></root>').root
      xml2 = REXML::Document.new('<test></test>').root
      assert_not_equal xml1, xml2
    end

    should 'be false when text is not equal' do
      xml1 = REXML::Document.new('<root>yeah</root>').root
      xml2 = REXML::Document.new('<root>no</root>').root
      assert_not_equal xml1, xml2
    end

    should 'be false when attributes are not equal at all' do
      xml1 = REXML::Document.new('<root neat="foo">yeah</root>').root
      xml2 = REXML::Document.new('<root wow="bar">yeah</root>').root
      assert_not_equal xml1, xml2
    end

    should 'be false when attributes are not equal but have same names' do
      xml1 = REXML::Document.new('<root neat="foo">yeah</root>').root
      xml2 = REXML::Document.new('<root neat="bar">yeah</root>').root
      assert_not_equal xml1, xml2
    end

    should 'be false when attributes are not equal but have same values' do
      xml1 = REXML::Document.new('<root neat="bar">yeah</root>').root
      xml2 = REXML::Document.new('<root cool="bar">yeah</root>').root
      assert_not_equal xml1, xml2
    end

    should 'be true when equal' do
      xml1 = REXML::Document.new('<root neat="bar">yeah</root>').root
      xml2 = REXML::Document.new('<root neat="bar">yeah</root>').root
      assert_equal xml1, xml2
    end

    should 'be true when equal except whitespace' do
      xml1 = REXML::Document.new('<root neat="bar">yeah</root>').root
      xml2 = REXML::Document.new("<root neat=\"bar\" >\nyeah</root>\n  \t\n").root
      assert_equal xml1, xml2
    end

    should 'be true when equal except attribute ordering' do
      xml1 = REXML::Document.new('<root neat="bar" cool="other">yeah</root>').root
      xml2 = REXML::Document.new('<root cool="other" neat="bar">yeah</root>').root
      assert_equal xml1, xml2
    end

    should 'be false when child elements are not equal' do
      xml1 = REXML::Document.new('<root neat="bar"><nested>yeah</nested></root>').root
      xml2 = REXML::Document.new('<root neat="bar"><nested>no</nested></root>').root
      assert_not_equal xml1, xml2
    end

    should 'be true when child elements equal but whitespace' do
      xml1 = REXML::Document.new("<root><nested>wow</nested><nested></nested></root>").root
      xml2 = REXML::Document.new("<root><nested>wow</nested>   \n\t<nested></nested></root>").root
      assert_equal xml1, xml2
    end

    should 'be true when child elements equal but order' do
      xml1 = REXML::Document.new("<root><nested>wow</nested><other></other></root>").root
      xml2 = REXML::Document.new("<root><other></other><nested>wow</nested></root>").root
      assert_equal xml1, xml2
    end
  end
end
