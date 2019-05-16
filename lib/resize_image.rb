require "aws-sdk-s3"
require "mini_magick"

class ResizeImage
  RESIZED_FILE_TMP = "/tmp/resized.jpg"
  BUCKET_URL = "http://#{ENV['BUCKET']}.s3-website.#{ENV['REGION']}.amazonaws.com"

  def initialize(object_name, size)
    @object_name = object_name
    @size = size
  end

  def call
    download_object
    resize
    upload_object

    "#{BUCKET_URL}/#{resized_object}"
  end

  private

  attr_reader :object_name, :size

  def bucket
    Aws::S3::Resource.new(region: 'eu-west-1').bucket(ENV['BUCKET'])
  end

  def source
    bucket.object(object_name)
  end

  def tmp_file_name 
    @tmp_file_name ||= "/tmp/#{object_name}"
  end

  def download_object
    source.get(response_target: tmp_file_name)
  end

  def resize
    image = MiniMagick::Image.open(tmp_file_name)
    image.resize(size)
    image.write(RESIZED_FILE_TMP)
  end

  def upload_object
    bucket.object(resized_object).upload_file(RESIZED_FILE_TMP)
  end

  def resized_object
    "#{size}_#{object_name}"
  end
end 
