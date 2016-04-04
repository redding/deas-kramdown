require 'pathname'
require 'kramdown'

module Deas; end
module Deas::Kramdown

  class Source

    attr_reader :root, :cache, :doc_opts

    def initialize(root, opts)
      @root     = Pathname.new(root.to_s)
      @doc_opts = opts[:doc_opts] || {}
      @cache    = opts[:cache] ? Hash.new : NullCache.new
    end

    def render(template_name)
      load(template_name).to_html
    end

    def compile(template_name, content)
      doc(content).to_html
    end

    def doc(content)
      Kramdown::Document.new(content, @doc_opts)
    end

    def inspect
      "#<#{self.class}:#{'0x0%x' % (object_id << 1)}"\
      " @root=#{@root.inspect}"\
      " @doc_opts=#{@doc_opts.inspect}>"
    end

    private

    def load(template_name)
      @cache[template_name] ||= begin
        file_path = source_file_path(template_name).to_s
        content = File.send(File.respond_to?(:binread) ? :binread : :read, file_path)
        doc(content)
      end
    end

    def source_file_path(template_name)
      Dir.glob(self.root.join("#{template_name}*")).first
    end

    class NullCache
      def [](template_name);         end
      def []=(template_name, value); end
      def keys; [];                  end
    end

  end

end
