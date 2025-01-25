class CtfController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  BASE_PATH = Rails.root.join("app", "assets", "ctf", "writeups")

  def sanitize_path(param)
    param.match?(/\A[\w\-]+\z/)
  end

  def index
    @categories = Dir.entries(BASE_PATH)
                     .select { |entry| File.directory?(BASE_PATH.join(entry)) && ![ ".", ".." ].include?(entry) }
  end

  def which
    unless sanitize_path(params[:which])
      render plain: "Invalid ctf", status: :bad_request
      return
    end

    which_path = BASE_PATH.join(params[:which])
    if Dir.exist?(which_path)
      @which = params[:which]
      @writeups = Dir.entries(which_path).select { |file| file.end_with?(".md") }
    else
      render plain: "Ctf not found", status: :not_found
    end
  end

  def writeup
    unless sanitize_path(params[:which]) && sanitize_path(params[:writeup].gsub(".md", ""))
      render plain: "Invalid writeup", status: :bad_request
      return
    end

    file_path = BASE_PATH.join(params[:which], params[:writeup])
    puts "file_path: #{file_path}"

    if file_path.exist? && file_path.file? && file_path.to_s.start_with?(BASE_PATH.to_s)
      markdown_text = File.read(file_path)
      renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
      markdown = Redcarpet::Markdown.new(renderer, {
        autolink: true,
        tables: true,
        fenced_code_blocks: true
      })
      @html_content = markdown.render(markdown_text).html_safe
      @which = params[:which]
      @writeup = params[:writeup]
    else
      render plain: "Writeup not found", status: :not_found
    end
  end
end
