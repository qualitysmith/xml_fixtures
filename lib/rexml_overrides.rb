class REXML::Element
  def ==(another_element)
    return false unless another_element.is_a?(REXML::Element)
    return false unless self.name == another_element.name
    return false unless self.text.try(:strip).to_s == another_element.text.try(:strip).to_s
    return false unless self.attributes == another_element.attributes
    return child_elements_equal?(another_element)
  end

  private

  def child_elements_equal?(another_element)
    return false unless self.elements.size == another_element.elements.size
    return true if self.elements.size == 0
    if children_look_like_an_array?
      return array_children_equal?( another_element )
    else
      return set_children_equal?( another_element )
    end
  end


  def children_look_like_an_array?
    return true if self.elements.size == 1
    return self.elements.collect(&:name).uniq.size == 1
  end
  
  def array_children_equal?( another_element )
    pairs = (1..(self.elements.size)).collect {|index| [ self.elements[index], another_element.elements[index] ] }
    return pairs.all? {|pair| pair.first == pair.last and pair.first.text.try(:strip).to_s == pair.last.text.try(:strip).to_s }
  end

  def set_children_equal?( another_element )
    other_set = get_child_list( another_element )
    return get_child_list( self ).all? {|child| other_set.any? {|another_child| another_child == child } }
  end

  def get_child_list( element )
    child_elements = element.elements.to_a
    element_names = child_elements.collect(&:name)
    raise "Had two children with the same name" if element_names.uniq.size != element_names.size
    return child_elements
  end
end

class REXML::Attributes
  def ==(another_attributes)
    return false unless another_attributes.is_a?(REXML::Attributes)
    return false unless self.size == another_attributes.size
    return self.keys.all? {|index| self[index] == another_attributes[index] }
  end
end
