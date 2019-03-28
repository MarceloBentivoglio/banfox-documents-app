class DocumentsController < ApplicationController
  def index
    @documents = policy_scope(Document).order(created_at: :desc)
  end

  def show
    @document = Document.find(params[:id])
    authorize @document
    @document = JSON.parse(@document.metadata, symbolize_names: true)
  end
end
