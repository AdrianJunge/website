class CtfController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  include MarkdownHelper

  BASE_PATH = Rails.root.join("app", "assets", "ctf", "writeups")
  CTF_INFO_PATH = Rails.root.join("app", "assets", "ctf", "ctfs.json")

  def sanitize_path(param)
    param.match?(/\A[\w\-]+\z/)
  end

  def index
    file = File.read(CTF_INFO_PATH)
    @ctfs = JSON.parse(file)
  end

  def which
    unless sanitize_path(params[:which])
      render plain: "Invalid ctf", status: :bad_request
      return
    end

    which_path = BASE_PATH.join(params[:which])
    if which_path && Dir.exist?(which_path)
      @which = params[:which]
      @writeups = Dir.entries(which_path)
                     .select { |file| file.end_with?(".md") }
                     .map { |file| file.sub(".md", "") }

      @ctf_info = fetch_ctf_info(@which, @writeups)
    else
      render plain: "Ctf not found", status: :not_found
    end
  end

  def writeup
    unless sanitize_path(params[:which]) && sanitize_path(params[:writeup].gsub(".md", ""))
      render plain: "Invalid writeup", status: :bad_request
      return
    end

    file_path = BASE_PATH.join(params[:which], (params[:writeup] + ".md"))

    if file_path.exist? && file_path.file? && file_path.to_s.start_with?(BASE_PATH.to_s)
      @markdown_content = File.read(file_path)
    else
      @markdown_content = "Markdown file not found"
    end
    @which = params[:which]
    @writeup = params[:writeup]
    @ctf_info = fetch_ctf_info(@which, [ @writeup ])
    @headings = get_writeup_headings(@which, @writeup)
    @html_content = render_markdown(@markdown_content)
  end

  private

  def fetch_ctf_info(which, writeups)
    ctf_info = {}

    writeups.each do |writeup|
      file_path = BASE_PATH.join(which, "#{writeup}.md")

      next unless File.exist?(file_path)
      writeup_header = File.read(file_path)
      parsed_writeup_header = begin
        FrontMatterParser::Parser.new(:md).call(writeup_header)
      rescue StandardError
        nil
      end

      next unless parsed_writeup_header

      parsed_hash = parsed_writeup_header.front_matter
      ctf_info[writeup] ||= {}
      ctf_info[writeup].merge!(parsed_hash)
    end

    ctf_info
  end

  def get_writeup_headings(which, writeup)
    headings = []
    file_path = BASE_PATH.join(which, "#{writeup}.md")

    if File.exist?(file_path)
      writeup_content = File.read(file_path)
      writeup_content.scan(/^#+\s*(.+)<a name="(.+)"><\/a>/) do |heading_text, anchor_name|
      headings << { text: heading_text.strip, anchor: anchor_name.strip }
      end
    end
    puts "headings: #{headings}"
    headings
  end
end
