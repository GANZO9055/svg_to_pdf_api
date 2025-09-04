# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'PDFs API', type: :request do
  path '/api/v1/pdfs' do
    post 'Конвертирует SVG в PDF' do
      tags 'PDFs'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :svg_file, in: :formData, type: :file, description: 'SVG файл'
      parameter name: :watermark, in: :formData, type: :string, description: 'Водяной знак', required: false

      response '200', 'PDF создан' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     type: { type: :string },
                     id: { type: :string },
                     attributes: {
                       type: :object,
                       properties: {
                         download_url: { type: :string }
                       },
                       required: ['download_url']
                     }
                   },
                   required: ['type', 'id', 'attributes']
                 }
               },
               required: ['data']

        let(:svg_file) { fixture_file_upload('files/test.svg', 'image/svg+xml') }
        let(:watermark) { 'TestWatermark' }

        run_test!
      end

      response '400', 'svg_file не передан' do
        let(:svg_file) { nil }
        let(:watermark) { 'NoFile' }

        run_test!
      end
    end
  end
end