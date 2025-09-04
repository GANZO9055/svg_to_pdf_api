# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pdf::SvgToPdfService do
  let(:fixtures_path) { Rails.root.join('spec', 'fixtures', 'files') }

  it "конвертирует test.svg в PDF с водяным знаком" do
    svg_path = fixtures_path.join('test.svg')
    File.open(svg_path, 'r') do |svg_io|
      service = described_class.new(svg_io: svg_io, watermark: "TEST")
      filename = service.call

      output_path = Rails.root.join("public", "generated_pdfs", filename)
      expect(File).to exist(output_path)

      file_size = File.size(output_path)
      expect(file_size).to be > 1000 # чтобы PDF не был пустым
    end
  end

  it "конвертирует test2.svg в PDF с водяным знаком" do
    svg_path = fixtures_path.join('test2.svg')
    File.open(svg_path, 'r') do |svg_io|
      service = described_class.new(svg_io: svg_io, watermark: "SECOND")
      filename = service.call

      output_path = Rails.root.join("public", "generated_pdfs", filename)
      expect(File).to exist(output_path)

      file_size = File.size(output_path)
      expect(file_size).to be > 1000
    end
  end
end