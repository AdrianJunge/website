class CtfController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  include MarkdownHelper

  BASE_PATH = Rails.root.join("app", "assets", "ctf", "writeups")
  CTF_INFO_PATH = Rails.root.join("app", "assets", "ctf", "ctfs.json")

  def index
    file = File.read(CTF_INFO_PATH)
    @ctfs = JSON.parse(file)
  end

  def which
    @which = params[:which]
    return unless sanitize_which(@which)

    @writeups = Dir.entries(BASE_PATH.join(@which))
                   .select { |file| file.end_with?(".md") }
                   .map { |file| file.sub(".md", "") }
    @ctf_info = fetch_ctf_info(@which, @writeups)
  end

  def writeup
    @which = params[:which]
    @writeup = params[:writeup]
    return unless sanitize_writeup(@which, @writeup)

    @ctf_info = fetch_ctf_info(@which, [ @writeup ])
    file_path = BASE_PATH.join(@which, (@writeup + ".md"))

    if file_path.exist? && file_path.file? && file_path.to_s.start_with?(BASE_PATH.to_s)
      @markdown_content = File.read(file_path)
    else
      @markdown_content = "Markdown file not found"
    end
    @headings = get_writeup_headings(@which, @writeup)
    @html_content = render_markdown(@markdown_content)
  end

  private

  def sanitize_which(which)
    unless sanitize_path(@which)
      render plain: "Invalid ctf", status: :bad_request
      false
    end

    folder_path = File.realpath(File.join(BASE_PATH, @which))
    if !folder_path.to_s.start_with?(BASE_PATH.to_s)
      render plain: "Path Traversal detected", status: :bad_request
      return false
    end

    available_ctfs = Dir.entries(BASE_PATH).select { |entry| File.directory?(File.join(BASE_PATH, entry)) && !entry.start_with?(".") }
    available_ctfs.include?(@which)
  end

  def sanitize_writeup(which, writeup)
    unless sanitize_path(@writeup) && sanitize_which(@which)
      render plain: "Invalid writeup", status: :bad_request
      false
    end

    directory = File.join(BASE_PATH, @which)
    file_path = File.realpath(BASE_PATH.join(@which, (@writeup + ".md")))
    if !file_path.to_s.start_with?(directory.to_s)
      render plain: "Path Traversal detected", status: :bad_request
      return false
    end

    if File.exist?(file_path)
      true
    else
      render plain: "Writeup not found", status: :not_found
      false
    end
  end

  def sanitize_path(param)
    param.match?(/\A[\w\-]+\z/)
  end

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
