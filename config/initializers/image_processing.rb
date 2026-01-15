require "image_processing/mini_magick"

Rails.application.config.after_initialize do
  if defined?(ImageProcessing::Vips)
    ImageProcessing.send(:remove_const, :Vips)
  end
end