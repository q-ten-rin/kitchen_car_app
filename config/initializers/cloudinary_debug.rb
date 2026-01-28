Rails.application.config.after_initialize do
  Rails.logger.info "Cloudinary: #{ENV['CLOUDINARY_CLOUD_NAME']}, #{ENV['CLOUDINARY_API_KEY']}, #{ENV['CLOUDINARY_API_SECRET']}"
end