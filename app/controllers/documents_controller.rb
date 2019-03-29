class DocumentsController < ApplicationController
  before_action :set_and_authorize_document, only: [:show, :download]

  def index
    @documents = policy_scope(Document).order(created_at: :desc)
  end

  def show
    @content = @document.individual_content
  end

  def download
    respond_to do |format|
      format.pdf { send_document_pdf }
    end
  end

  private

  def send_document_pdf
    send_file @document.to_pdf, download_attributes
  end

  def download_attributes
    {
      filename: @document.filename,
      type: "application/pdf",
      disposition: "attachment"
    }
  end

  def set_and_authorize_document
    @document = Document.find(params[:id])
    authorize @document
  end


end
