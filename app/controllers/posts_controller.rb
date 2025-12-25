class PostsController < ApplicationController
  def timeline
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
          description: meta["description"].to_s,
        }
      end
    end

    grouped = items.group_by { |i| i[:published].year }
    @timeline = grouped.keys.sort.reverse.map { |year|
      [year, grouped[year].sort_by { |i| -i[:published].to_i }]
    }
  end
end
