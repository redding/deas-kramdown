require 'assert/factory'

module Factory
  extend Assert::Factory

  def self.template_root
    TEMPLATE_ROOT.to_s
  end

  def self.template_file(name)
    TEMPLATE_ROOT.join(name).to_s
  end

  def self.basic_markdown_rendered
    "<h1 id=\"some-heading\">Some Heading</h1>\n"
  end

end
