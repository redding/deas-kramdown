require 'deas/template_engine'
require 'kramdown'

require "deas-kramdown/version"
require 'deas-kramdown/source'

module Deas::Kramdown

  class TemplateEngine < Deas::TemplateEngine

    def kramdown_source
      @kramdown_source ||= Source.new(self.source_path, {
        :doc_opts => self.opts['doc_opts'],
        :cache    => self.opts['cache']
      })
    end

    # Render straight markdown templates.  As no ruby will be evaluated the view
    # handler, locals and content block will be ignored.
    def render(template_name, view_handler, locals, &content)
      self.kramdown_source.render(template_name)
    end

    # Render straight markdown partial templates.  As no ruby will be evaluated
    # the locals and content block will be ignored.
    def partial(template_name, locals, &content)
      self.kramdown_source.render(template_name)
    end

    # this is used when chaining engines where another engine initially loads the
    # template file
    def compile(template_name, compiled_content)
      self.kramdown_source.compile(template_name, compiled_content)
    end

  end

end
