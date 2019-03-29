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
    JSON.parse(metadata, symbolize_names: true)
  end

  private

  def as_html
    ApplicationController.render(render_attributes)
  end
end
