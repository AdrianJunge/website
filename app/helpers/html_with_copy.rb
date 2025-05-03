require "cgi"
require "rouge"
require "rouge/plugins/redcarpet"

class HtmlWithCopy < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def block_code(code, language)
    lexer       = Rouge::Lexer.find_fancy(language || "text", code)
    formatter   = Rouge::Formatters::HTML.new
    highlighted = formatter.format(lexer.lex(code))

    escaped     = CGI.escapeHTML(code)

    <<~HTML
      <div class="code-block">
        <button class="copy-btn" data-code="#{escaped}" title="Copy to clipboard">
          📋
        </button>
        <pre class="highlight"><code>#{highlighted}</code></pre>
      </div>
    HTML
  end
end
