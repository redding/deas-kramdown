require 'assert'
require 'deas-kramdown'

require 'deas/template_source'

class Deas::Kramdown::TemplateEngine

  class SystemTests < Assert::Context
    desc "Deas::Kramdown::TemplateEngine"
    setup do
      @view = OpenStruct.new({
        :identifier => Factory.integer,
        :name       => Factory.string
      })
      @locals  = { 'local1' => Factory.string }
      @content = Proc.new{ Factory.string }

      @engine = Deas::Kramdown::TemplateEngine.new('source_path' => TEMPLATE_ROOT)
    end
    subject{ @engine }

    should "render templates (ignoring the view/locals/content)" do
      exp = Factory.basic_markdown_rendered
      assert_equal exp, subject.render('basic', @view, @locals)
      assert_equal exp, subject.render('basic', @view, @locals, &@content)
    end

    should "render partial templates (ignoring the locals/content)" do
      exp = Factory.basic_markdown_rendered
      assert_equal exp, subject.partial('_basic', @locals)
      assert_equal exp, subject.partial('_basic', @locals, &@content)
    end

    should "compile raw template markup" do
      template_name = 'basic_alt'
      file_path     = TEMPLATE_ROOT.join("#{template_name}.markdown").to_s
      file_content  = File.read(file_path)

      exp = Factory.basic_markdown_rendered
      assert_equal exp, subject.compile(template_name, file_content)
    end

  end

end
