module CtfHelper
  def get_category_svg(category)
    svg = case category.downcase
    when "web"
      File.read(Rails.root.join("app", "assets", "ctf", "categories", "web.svg"))
    when "pwn"
      File.read(Rails.root.join("app", "assets", "ctf", "categories", "pwn.svg"))
    when "crypto"
      File.read(Rails.root.join("app", "assets", "ctf", "categories", "crypto.svg"))
    else
      File.read(Rails.root.join("app", "assets", "ctf", "categories", "default.svg"))
    end

    svg.gsub("<svg", '<svg style="width: 60px; height: 60px;"')
  end

  def render_writeup_card(writeup, writeup_path, which, category, description)
    content_tag(:a, href: writeup_path) do
      concat(content_tag(:div, class: "flex items-center") do
        concat(get_category_svg(category).html_safe)

        concat(content_tag(:h5, class: "ml-4 text-2xl font-semibold tracking-tight text-gray-900 dark:text-white") do
          writeup.capitalize
        end)
      end)

      concat(
        content_tag(:div, class: "writeup-details") do
          concat(content_tag(:p, class: "text-gray-500 dark:text-gray-400") do
            "Description: #{description}"
          end)

          concat(content_tag(:p, class: "text-gray-500 dark:text-gray-400") do
            "Category: #{category.capitalize}"
          end)
        end
      )
    end
  end
end
