# frozen_string_literal: true

module Api
  module V1
    class PdfsController < ApplicationController

      include ActionController::RequestForgeryProtection
      protect_from_forgery with: :null_session

      def create
        unless params[:svg_file].present?
          return render json: { errors: [{ detail: 'svg_file is required' }] }, status: :bad_request
        end

        filename = Pdf::SvgToPdfService.new(
          svg_io: params[:svg_file].tempfile,
          watermark: params[:watermark] || 'Watermark'
        ).call

        render json: { data: { type: 'pdf', id: filename, attributes: { download_url: "/generated_pdfs/#{filename}" } } }
      rescue => e
        render json: { errors: [{ detail: e.message }] }, status: :internal_server_error
      end
    end

    def show
      pdf = PdfDocument.find(params[:id])
      send_file pdf.path, type: "application/pdf", disposition: "attachment"
    end
  end
end
