require 'assert'
require 'deas-kramdown/source'

require 'kramdown'

class Deas::Kramdown::Source

  class UnitTests < Assert::Context
    desc "Deas::Kramdown::Source"
    setup do
      @source_class = Deas::Kramdown::Source
    end
    subject{ @source_class }

  end

  class InitTests < UnitTests
    desc "when init"
    setup do
      @doc_opts = { Factory.string => Factory.string }
      @root = Factory.template_root
      @source = @source_class.new(@root, :doc_opts => @doc_opts)
    end
    subject{ @source }

    should have_readers :root, :cache, :doc_opts
    should have_imeths :render, :compile, :doc

    should "know its root" do
      assert_equal @root, subject.root.to_s
    end

    should "not cache templates by default" do
      assert_kind_of NullCache, subject.cache
    end

    should "cache templates if the :cache opt is `true`" do
      source = @source_class.new(@root, :cache => true)
      assert_kind_of Hash, source.cache
    end

    should "know its doc options" do
      assert_equal @doc_opts, subject.doc_opts
      assert_equal Hash.new,  @source_class.new(@root, {}).doc_opts
    end

    should "build kramdown doc objects from template content" do
      content  = '# Some Heading'
      kdoc = Kramdown::Document.new(content, @doc_opts)
      kdoc_called_with = []
      Assert.stub(Kramdown::Document, :new) do |*args|
        kdoc_called_with = args
        kdoc
      end

      doc = subject.doc(content)
      assert_instance_of Kramdown::Document, doc

      exp = [content, @doc_opts]
      assert_equal exp, kdoc_called_with
    end

  end

  class RenderTests < InitTests
    desc "`render` method"
    setup do
      @template_name = ['basic', 'basic_alt'].choice
    end

    should "render a template for the given template name and return its data" do
      exp = Factory.basic_markdown_rendered
      assert_equal exp, subject.render(@template_name)
    end

  end

  class RenderCacheTests < RenderTests
    desc "when caching is enabled"
    setup do
      @source = @source_class.new(@root, :cache => true)
    end

    should "cache templates by their template name" do
      exp = Factory.basic_markdown_rendered
      assert_equal exp, @source.render(@template_name)

      assert_equal [@template_name], @source.cache.keys
      assert_kind_of Kramdown::Document, @source.cache[@template_name]
    end

  end

  class RenderNoCacheTests < RenderTests
    desc "when caching is disabled"
    setup do
      @source = @source_class.new(@root, :cache => false)
    end

    should "not cache templates" do
      exp = Factory.basic_markdown_rendered
      assert_equal exp, @source.render(@template_name)

      assert_equal [], @source.cache.keys
    end

  end

  class CompileTests < InitTests
    desc "`compile` method"

    should "evaluate raw template output and return it" do
      raw = "## Another Heading"
      exp = "<h2 id=\"another-heading\">Another Heading</h2>\n"
      assert_equal exp, subject.compile('compile', raw)
    end

  end

  class NullCacheTests < UnitTests
    desc "NullCache"
    setup do
      @cache = NullCache.new
    end
    subject{ @cache }

    should have_imeths :[], :[]=, :keys

    should "take a template name and return nothing on index" do
      assert_nil subject[Factory.path]
    end

    should "take a template name and value and do nothing on index write" do
      assert_nothing_raised do
        subject[Factory.path] = Factory.string
      end
    end

    should "always have empty keys" do
      assert_equal [], subject.keys
    end

  end

end
