require 'base64'
require 'json'
require 'net/https'
require "google/cloud/vision/v1"

module Vision
  class << self
    def image_analysis(post_image)
      if Rails.env.production?
        # 本番環境用のロジック
        keyfile_json_content = ENV['GOOGLE_APPLICATION_CREDENTIALS']
        require 'tempfile'
        keyfile = Tempfile.new('google_credentials')
        begin
          keyfile.write(keyfile_json_content)
          keyfile.rewind
          ENV['GOOGLE_APPLICATION_CREDENTIALS'] = keyfile.path

          image_annotator = create_image_annotator(post_image)
          analyze_image(image_annotator, post_image.path)
        ensure
          keyfile.close
          keyfile.unlink
        end
      else
        # 開発環境用のロジック
        ENV['GOOGLE_APPLICATION_CREDENTIALS']
        image_annotator = create_image_annotator(post_image)
        analyze_image(image_annotator, post_image.path)
      end
    end

    private

    def create_image_annotator(post_image)
      image_path = post_image
      Google::Cloud::Vision::V1::ImageAnnotator::Client.new
    end

    def analyze_image(image_annotator, image_path)
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