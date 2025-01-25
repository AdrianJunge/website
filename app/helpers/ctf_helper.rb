module CtfHelper
  def get_category_svg(category)
    svg_filename = Rails.root.join("app", "assets", "ctf", "categories", "#{category.downcase}.svg")
    svg_path = File.exist?(svg_filename) ? svg_filename : Rails.root.join("app", "assets", "ctf", "categories", "default.svg")
    svg = File.read(svg_path)
    svg.gsub("<svg", '<svg style="width: 60px; height: 60px;"')
  end

  def render_writeup_card(writeup, writeup_path, which, category, description)
    max_description_length = 100

    content_tag(:a, href: writeup_path) do
      concat(content_tag(:div, class: "flex items-center") do
        concat(get_category_svg(category).html_safe)

        concat(content_tag(:h5, class: "ml-4 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white") do
          writeup.capitalize
        end)
      end)

      concat(
        content_tag(:div, class: "writeup-details") do
          truncated_description = description.length > max_description_length ? "#{description[0, max_description_length]}..." : description

          concat(content_tag(:p, class: "text-gray-500 dark:text-gray-400") do
            "Category: #{category.capitalize}"
          end)

          concat(content_tag(:br))

          concat(content_tag(:p, class: "text-gray-500 dark:text-gray-400 italic") do
            "#{truncated_description}"
          end)
        end
      )
    end
  end
end
