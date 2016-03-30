# Deas::Nm

[Deas](https://github.com/redding/deas) template engine for rendering [Kramdown](http://kramdown.gettalong.org/) templates

## Usage

Register the engine:

```ruby
require 'deas'
require 'deas-kramdown'

Deas.configure do |c|

  c.template_source "/path/to/templates" do |s|
    s.engine 'md', Deas::Kramdown::TemplateEngine
  end

end
```

Add `.md` to any template files in your template source path.  Deas will render their content using Kramdown when they are rendered.

## Installation

Add this line to your application's Gemfile:

    gem 'deas-kramdown'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deas-kramdown

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
