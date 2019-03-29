class Document < ApplicationRecord
  belongs_to :user

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_file("tmp/operation.pdf")
  end

  # def filename
  #   "Operation.pdf"
  # end

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

  # private

  def as_html
    # render render_attributes
    ApplicationController.render(render_attributes)

    # render partial: "#{self.to_partial_path}", object: self, layout: 'pdf'
    # DocumentsController.render :show
    # ApplicationController.render :template "documents/show", :document => id
    # DocumentsController.render :show, assigns: { document: individual_content }
    # ApplicationController.render 'documents/show', assigns: { document: individual_content }
  end
end
