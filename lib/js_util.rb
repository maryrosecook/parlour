module JSUtil
  
  def self.blank_elements(page, elements)
    elements.each { |element| page.replace_html element, "" }
  end
end