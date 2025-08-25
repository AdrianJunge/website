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
    file = File.read(CTF_INFO_PATH)
    @ctfs = JSON.parse(file)
    @ctf = @ctfs[params[:which].upcase] if @ctfs.key?(params[:which].upcase)
    @which = params[:which].gsub("..", "").gsub("/", "")
    return unless sanitize_which(@which)

    @writeups = Dir.entries(BASE_PATH.join(@which))
                   .select { |file| file.end_with?(".md") }
                   .map { |file| file.sub(".md", "") }
    @ctf_info = get_ctf_infos(@which, @writeups)
  end

  def writeup
    @which = params[:which].gsub("..", "").gsub("/", "")
    @writeup = params[:writeup].gsub("..", "").gsub("/", "")
    return unless sanitize_writeup(@which, @writeup)

    file_path = BASE_PATH.join(@which, (@writeup + ".md"))

    if file_path.exist? && file_path.file? && file_path.to_s.start_with?(BASE_PATH.to_s)
      @markdown_content = File.read(file_path)
    else
      @markdown_content = "Markdown file not found"
    end
    @ctf_info = get_ctf_info(@markdown_content)
    @headings = get_writeup_headings(@which, @writeup)
    @html_content = render_markdown(@markdown_content)
  end

  def feed
    @items = []

    Dir.entries(BASE_PATH).select { |entry|
      File.directory?(BASE_PATH.join(entry)) && !entry.start_with?(".")
    }.each do |which_dir|
      Dir.glob(BASE_PATH.join(which_dir, "*.md")).each do |file_path|
        next unless File.file?(file_path)

        content = File.read(file_path)
        parsed = get_ctf_info(content)
        next unless parsed

        meta = parsed.front_matter || {}
        title = meta["title"].presence || File.basename(file_path, ".md").humanize
        description = (meta["description"].presence || parsed.content.to_s[0, 800]).to_s
        pub_date = begin
                     Time.parse(meta["published"].to_s)
                   rescue StandardError
                     File.ctime(file_path)
                   end

        writeup_slug = File.basename(file_path, ".md")
        link = url_for(controller: "ctf", action: "writeup", which: which_dir, writeup: writeup_slug, only_path: false)

        @items << {
          ctf: which_dir,
          title: sanitize(title),
          description: sanitize(description, tags: %w[p br strong em a code pre img], attributes: %w[href src alt title]),
          link: link,
          pub_date: pub_date,
          guid: link
        }
      end
    end

    @items.sort_by! { |i| -i[:pub_date].to_i }
    respond_to do |format|
      format.rss { render layout: false }
      format.atom { render layout: false }
    end
  end

  private

  def sanitize_which(which)
    unless sanitize_path(@which)
      render plain: "Invalid ctf", status: :bad_request
      return false
    end

    begin
      folder_path = File.realpath(File.join(BASE_PATH, @which))
      if !folder_path.to_s.start_with?(BASE_PATH.to_s)
        render plain: "Path Traversal detected", status: :bad_request
        return false
      end
      available_ctfs = Dir.entries(BASE_PATH).select { |entry| File.directory?(File.join(BASE_PATH, entry)) && !entry.start_with?(".") }
      available_ctfs.include?(@which)
    rescue StandardError
      render plain: "Invalid ctf", status: :bad_request
      false
    end
  end

  def sanitize_writeup(which, writeup)
    unless sanitize_path(@writeup) && sanitize_which(@which)
      render plain: "Invalid writeup", status: :bad_request
      return false
    end

    directory = File.join(BASE_PATH, @which)

    begin
      file_path = File.realpath(BASE_PATH.join(@which, (@writeup + ".md")))
      if !file_path.to_s.start_with?(directory.to_s)
        render plain: "Path Traversal detected", status: :bad_request
        return false
      end
    rescue StandardError
      render plain: "Invalid writeup", status: :bad_request
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
    param.match?(/^[a-zA-Z\s]+$/)
  end

  def get_ctf_infos(which, writeups)
    ctf_info = {}

    writeups.each do |writeup|
      file_path = BASE_PATH.join(which, "#{writeup}.md")

      next unless File.exist?(file_path)
      writeup_header = File.read(file_path)

      parsed_writeup_header = get_ctf_info(writeup_header)
      next unless parsed_writeup_header

      parsed_hash = parsed_writeup_header.front_matter

      ctf_info[writeup] ||= {}
      ctf_info[writeup].merge!(parsed_hash)
    end

    ctf_info
  end

  def get_ctf_info(writeup_content)
    parsed_writeup_header = begin
      FrontMatterParser::Parser.new(:md).call(writeup_content)
    rescue StandardError
      nil
    end
    parsed_writeup_header
  end

  def get_writeup_headings(which, writeup)
    headings = []
    file_path = BASE_PATH.join(which, "#{writeup}.md")

    if File.exist?(file_path)
      writeup_content = File.read(file_path)
      writeup_content.scan(/^#+\s*(.+)<a id="(.+)"><\/a>/) do |heading_text, anchor_name|
      headings << { text: heading_text.strip, anchor: anchor_name.strip }
      end
    end
    headings
  end
end
