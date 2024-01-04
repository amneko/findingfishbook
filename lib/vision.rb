require 'base64'
require 'json'
require 'net/https'
require "google/cloud/vision/v1"

ENV['GOOGLE_APPLICATION_CREDENTIALS']

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