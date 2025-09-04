# frozen_string_literal: true

class PdfSerializer
  include JSONAPI::Serializer

  set_type :pdf
  attributes :filename, :url, :size, :created_at
end
