class Document < ApplicationRecord
  belongs_to :user

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_file("tmp/#{filename}")
  end

  def filename
    "operacao-#{individual_content[:operation][:id]}.pdf"
  end

  def render_attributes
    {
      template: "documents/pdf",
      layout: "pdf",
      locals: { document: individual_content }
    }
  end

  def individual_content
    variable_content.deep_symbolize_keys
  end

  def to_base_64_file
    Base64.encode64(to_pdf.read)
  end

  private

  def as_html
    ApplicationController.render(render_attributes)
  end
end
