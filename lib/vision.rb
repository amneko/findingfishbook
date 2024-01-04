require 'base64'
require 'json'
require 'net/https'
require "google/cloud/vision/v1"

keyfile_json_content = ENV['GOOGLE_APPLICATION_CREDENTIALS']

require 'tempfile'
keyfile = Tempfile.new('google_credentials')
keyfile.write(keyfile_json_content)
keyfile.rewind

ENV['GOOGLE_APPLICATION_CREDENTIALS'] = keyfile.path

module Vision
  class << self
    def image_analysis(post_image)
      image_path = post_image
      image_annotator = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
      response = image_annotator.label_detection(
        image:       image_path,
        max_results: 10
      )

      response.responses.each do |res|
        res.label_annotations.each do |label|
          return true if label.description.include?('Fish')
        end
      end
      false
    end
  end
end

keyfile.close
keyfile.unlink