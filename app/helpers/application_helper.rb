module ApplicationHelper
  def asset_exists?(filename)
    Rails.root.join("app/assets/stylesheets", filename).exist?
  end
end
