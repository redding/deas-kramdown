require 'assert'
require 'deas-kramdown'

require 'deas/template_engine'
require 'deas-kramdown/source'

class Deas::Kramdown::TemplateEngine

  class UnitTests < Assert::Context
    desc "Deas::Kramdown::TemplateEngine"
    setup do
      @engine = Deas::Kramdown::TemplateEngine.new({
        'source_path' => TEST_SUPPORT_PATH
      })
    end
    subject{ @engine }

    should have_imeths :kramdown_source
    should have_imeths :render, :partial, :compile

    should "be a Deas template engine" do
      assert_kind_of Deas::TemplateEngine, subject
    end

    should "memoize its kramdown source" do
      assert_kind_of Deas::Kramdown::Source, subject.kramdown_source
      assert_equal subject.source_path, subject.kramdown_source.root
      assert_same subject.kramdown_source, subject.kramdown_source
    end

    should "allow custom doc opts on its source" do
      doc_opts = { Factory.string => Factory.string }
      engine = Deas::Kramdown::TemplateEngine.new('doc_opts' => doc_opts)
      assert_equal doc_opts, engine.kramdown_source.doc_opts
    end

    should "pass any given cache option to its source" do
      engine = Deas::Kramdown::TemplateEngine.new('cache' => true)
      assert_kind_of Hash, engine.kramdown_source.cache
    end

  end

  # render, partial and compile tests are covered in the system tests

end
