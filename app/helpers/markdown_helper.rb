module MarkdownHelper
  require "redcarpet"
  require "rouge"
  require "rouge/plugins/redcarpet"

  class RougeHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def render_markdown(text)
    sanitized_text = text.gsub(/---([\S\s]*)---/, "").strip

    render_options = {
      no_links: false,
      hard_wrap: true,
      link_attributes: { target: "_blank" }
    }
    extensions = {
      disable_indented_code_blocks: true,
      hard_wrap: true,
      autolink: true,
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
      quote: true,
      footnotes: true,
      highlight: true,
      underline: true
    }
    renderer = RougeHTML.new(render_options)

    html_content = "<div class='markdown-content'>
      <span style='color:white'>
        #{Redcarpet::Markdown.new(renderer, extensions).render(sanitized_text)}
      </span>
    </div>"

    html_content.gsub!(/"\/?([A-z0-9\-_+]+\/)*([A-z0-9]+\.([A-z0-9])*)"/) do |match|
      match = match.gsub(/"/, "")
      ActionController::Base.helpers.asset_path(match)
    end

    html_content.html_safe
  end
end
