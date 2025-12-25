class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  BASE_PATH = Rails.root.join("app", "assets", "ctf", "writeups")
  CTF_INFO_PATH = Rails.root.join("app", "assets", "ctf", "ctfs.json")

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

  def get_all_ctf_infos
    file = File.read(CTF_INFO_PATH)
    ctfs = JSON.parse(file)
    ctf_infos = []
    ctfs.each_key do |which|
      writeups = Dir.entries(BASE_PATH.join(which.downcase))
                   .select { |file| file.end_with?(".md") }
                   .map { |file| file.sub(".md", "") }
      ctf_info = get_ctf_infos(which.downcase, writeups)
      ctf_infos << ctf_info
    end
    ctf_infos
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

  def get_timeline
    items = []

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
        published = begin
                      Time.parse(meta["published"].to_s)
                    rescue StandardError
                      File.ctime(file_path)
                    end

        slug = File.basename(file_path, ".md")
        link = "/ctf/#{which_dir.downcase}/#{slug}"

        items << {
          which: which_dir.downcase,
          slug: slug,
          title: title,
          published: published,
          link: link,
          description: meta["description"].to_s
        }
      end
    end

    grouped = items.group_by { |i| i[:published].year }
    timeline = grouped.keys.sort.reverse.map { |year|
      [ year, grouped[year].sort_by { |i| -i[:published].to_i } ]
    }
    timeline
  end
end
