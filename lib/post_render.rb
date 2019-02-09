require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
# Custom renderer for Markdown syntax
class PostRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end