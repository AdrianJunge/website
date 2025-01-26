module MarkdownHelper
  def render_markdown(text)
    sanitized_text = text.gsub(/---([\S\s]*)---/, "").strip

    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer, {
      autolink: true,
      tables: true,
      fenced_code_blocks: true
    })

    html_content = "<div class='markdown-content'>
      #{markdown.render(sanitized_text)}
    </div>"

    html_content.gsub!(/"\/?([A-z0-9-_+]+\/)*([A-z0-9]+\.([A-z0-9])*)"/) do |match|
      match = match.gsub(/"/, "")
      ActionController::Base.helpers.asset_path(match)
    end

    html_content.html_safe
  end
end
