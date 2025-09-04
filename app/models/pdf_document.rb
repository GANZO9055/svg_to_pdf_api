# frozen_string_literal: true

class PdfDocument
  attr_reader :filename, :path, :watermark, :created_at, :size

  BASE_DIR = Rails.root.join('public', 'generated_pdfs')

  def initialize(filename:, watermark:)
    @filename = filename
    @path = BASE_DIR.join(filename)
    @watermark = watermark
    @created_at = File.mtime(@path)
    @size = File.size(@path)
  end

  def self.create_from_svg(svg_io, watermark)
    filename = Pdf::SvgToPdfService.new(svg_io: svg_io, watermark: watermark).call
    new(filename: filename, watermark: watermark)
  end

  def url
    Rails.application.routes.url_helpers.api_v1_pdf_path(filename)
  end
end
