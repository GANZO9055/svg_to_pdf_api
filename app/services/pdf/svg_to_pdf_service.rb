# frozen_string_literal: true

require 'prawn'
require 'prawn-svg'

module Pdf
  class SvgToPdfService
    CM_TO_PT = 28.3464567
    DEFAULT_MARGIN_CM = 1.0

    def initialize(svg_io:, watermark:, margin_cm: DEFAULT_MARGIN_CM)
      @svg_io = svg_io
      @watermark = watermark
      @margin_pt = margin_cm * CM_TO_PT
    end

    def call
      svg_content = @svg_io.read
      filename = "converted_#{Time.now.to_i}.pdf"
      output_dir = Rails.root.join('public', 'generated_pdfs')
      FileUtils.mkdir_p(output_dir)
      output_path = output_dir.join(filename).to_s

      Prawn::Document.generate(output_path, page_size: 'A4', margin: @margin_pt) do |pdf|
        content_width = pdf.bounds.width
        content_height = pdf.bounds.height

        pdf.move_cursor_to(pdf.bounds.top)
        pdf.svg(svg_content, width: content_width)

        draw_frame_and_crop_marks(pdf, content_width, content_height)
        draw_watermark(pdf)
      end

      filename
    end

    def draw_frame_and_crop_marks(pdf, width, height)
      top_y = pdf.bounds.top
      left_x = 0
      pdf.stroke_color '000000'
      pdf.line_width 0.5
      pdf.stroke_rectangle [left_x, top_y], width, height

      crop_len = 0.5 * CM_TO_PT
      pdf.stroke_line [left_x, top_y], [left_x + crop_len, top_y]
      pdf.stroke_line [left_x, top_y], [left_x, top_y - crop_len]

      pdf.stroke_line [left_x + width - crop_len, top_y], [left_x + width, top_y]
      pdf.stroke_line [left_x + width, top_y], [left_x + width, top_y - crop_len]

      pdf.stroke_line [left_x, crop_len], [left_x + crop_len, crop_len]
      pdf.stroke_line [left_x, 0], [left_x, crop_len]

      pdf.stroke_line [left_x + width - crop_len, 0], [left_x + width, 0]
      pdf.stroke_line [left_x + width, 0], [left_x + width, crop_len]
    end

    def draw_watermark(pdf)
      font_path = Rails.root.join('app/assets/fonts/dejavu-fonts-ttf-2.37/ttf/DejaVuSans.ttf')
      pdf.font(font_path)
      pdf.fill_color '000000'
      pdf.transparent(0.08) do
        cx = pdf.bounds.width / 2.0
        cy = pdf.bounds.height / 2.0
        pdf.save_graphics_state do
          pdf.translate(cx, cy) do
            pdf.rotate(45) do
              pdf.draw_text @watermark, at: [-pdf.bounds.width / 4.0, -20], size: 72
            end
          end
        end
      end
      pdf.fill_color '000000'
    end
  end
end
