require "#{Rails.root}/lib/post_render.rb"

module ApplicationHelper
  # class CodeRayify < Redcarpet::Render::HTML
  #   def block_code(code, language)
  #     language ||= :plaintext
  #     CodeRay.scan(code, language).div
  #   end
  # end
  
  # def markdown(text)
  #   coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
  #   options = {
  #     fenced_code_blocks: true,
  #     no_intra_emphasis: true,
  #     autolink: true,
  #     lax_html_blocks: true,
  #   }
    
  #   markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    
  #   markdown_to_html.render(text).html_safe
  # end

  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    render_options = {
        filter_html: true,
        hard_wrap: true,
        link_attributes: { rel: 'nofollow' }
    }
    renderer = HTML.new(render_options)

    extensions = {
        autolink: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        no_intra_emphasis: true,
        strikethrough: true,
        superscript: true
    }

    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
