module ImageProcessingHelper
  def should_invert_image?(image_path)
    full_image_path = Rails.root.join("app", "assets", "images", image_path)
    return false unless File.exist?(full_image_path)

    begin
      image = MiniMagick::Image.open(full_image_path)
      histogram = image.colorspace("Gray").get_pixels.flatten
      bright_pixels_count = histogram.count { |pixel| pixel > 200 }
      white_ratio = bright_pixels_count.to_f / histogram.size
      if white_ratio > 0.5
        invert_and_backup_image(full_image_path)
        return true
      end
      false
    rescue => e
      Rails.logger.error "Bildanalysis failed: #{e.message}"
      false
    end
  end

  def invert_and_backup_image(full_image_path)
    backup_path = full_image_path.to_s.sub(/(\.\w+)$/, '_backup\1')

    image = MiniMagick::Image.open(full_image_path)

    unless File.exist?(backup_path)
      FileUtils.cp(full_image_path, backup_path)
      Rails.logger.info "Backup saved at: #{backup_path}"
    end

    image.negate
    image.write(full_image_path)
    Rails.logger.info "Inverted image saved at: #{full_image_path}"
  end
end
