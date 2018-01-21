class AttachmentUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::ImageOptimizer

  # Choose what kind of storage to use for this uploader:
  storage :aws
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.account.subdomain}/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  process :save_content_type_in_model
  process resize_to_limit: [2048, 2048], if: :is_image?
  process :strip, if: :is_image?
  process optimize: [{ quality: 70 }], if: :is_image?

  # Create different versions of your uploaded files:
  # version :large_hi_dpi do
  #   process resize_to_fit: [200, 200] if :is_square?
  #   process resize_to_fit: [400, 200] if :is_landscape?
  #   process resize_to_fit: [200, 400] if :is_portrait?
  # end
  # 
  # version :large, from_version: :large_hi_dpi do
  #   process resize_to_fit: [200, 200] if :is_square?
  #   process resize_to_fit: [400, 200] if :is_landscape?
  #   process resize_to_fit: [200, 400] if :is_portrait?
  # end
  # 
  # version :medium_hi_dpi, from_version: :large_hi_dpi do
  #   process resize_to_fit: [200, 200] if :is_square?
  #   process resize_to_fit: [400, 200] if :is_landscape?
  #   process resize_to_fit: [200, 400] if :is_portrait?
  # end
  # 
  # version :medium, from_version: :large do
  #   process resize_to_fit: [200, 200] if :is_square?
  #   process resize_to_fit: [400, 200] if :is_landscape?
  #   process resize_to_fit: [200, 400] if :is_portrait?
  # end
  # 
  # version :small_hi_dpi, from_version: :medium_hi_dpi do
  #   process resize_to_fit: [200, 200] if :is_square?
  #   process resize_to_fit: [400, 200] if :is_landscape?
  #   process resize_to_fit: [200, 400] if :is_portrait?
  # end
  # 
  # version :small, from_version: :medium do
  #   process resize_to_fit: [200, 200] if :is_square?
  #   process resize_to_fit: [400, 200] if :is_landscape?
  #   process resize_to_fit: [200, 400] if :is_portrait?
  # end
  # 
  # version :thumb, from_version: :small do
  #   process resize_to_fit: [20, 20] if :is_square?
  #   process resize_to_fit: [40, 20] if :is_landscape?
  #   process resize_to_fit: [20, 40] if :is_portrait?
  # end
  version :thumbnail, if: :is_image? do
    process resize_to_fill: [300, 300]
    process :strip
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png tif tiff avi m4v mov mp4 mpg mpeg mpeg wmv qt)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def is_image? file
    file.content_type.include? 'image'
  end

  def is_video? file
    file.content_type.include? 'video'
  end

  def save_content_type_in_model
    model.content_type = file.content_type if file.content_type
  end

  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

  # def is_square? photo
  #   image = MiniMagick::Image.open(photo.path)
  #   image[:width] = image[:height]
  # end
  # 
  # def is_landscape? photo
  #   image = MiniMagick::Image.open(photo.path)
  #   image[:width] > image[:height]
  # end
  # 
  # def is_portrait? photo
  #   image = MiniMagick::Image.open(photo.path)
  #   image[:width] < image[:height]
  # end
end
