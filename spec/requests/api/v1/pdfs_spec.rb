# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Api::V1::PdfsController", type: :request do
  svg_files = {
    'test.svg' => 'test.svg',
    'test2.svg' => 'test2.svg'
  }

  svg_files.each do |name, filename|
    it "возвращает PDF при отправке #{name}" do
      svg_file = fixture_file_upload("spec/fixtures/files/#{filename}", 'image/svg+xml')

      post "/api/v1/pdfs", params: { svg_file: svg_file, watermark: "TestWatermark" }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      download_url = json['data']['attributes']['download_url']
      file_path = Rails.root.join('public', download_url.sub(%r{^/}, ''))
      expect(File).to exist(file_path)
    end

    it "возвращает ошибку если svg_file не передан" do
      post "/api/v1/pdfs", params: { watermark: "NoFile" }

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)
      expect(json['errors'].first['detail']).to eq('svg_file is required')
    end
  end
end
