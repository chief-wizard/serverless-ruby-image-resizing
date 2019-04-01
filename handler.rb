require 'json'
require './resize_image'

def call(event:, context:)
  begin
    size = event["pathParameters"]["size"]
    image = event["pathParameters"]["image"]

    resized_image_url = ResizeImage.new(image, size).call

    { 
      headers: { location: resized_image_url }, 
      statusCode: 301, 
      body: ''
    }
  rescue StandardError => e  
    puts e.message
    puts e.backtrace.inspect
    { statusCode: 400, body: JSON.generate(e.message) }
  end
end
