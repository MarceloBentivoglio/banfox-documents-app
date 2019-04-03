class Api::V1::DocumentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  def create
    variable_content = JSON.parse(request.body.read)
    @document = Document.new(variable_content: variable_content)
    @document.user = current_user
    authorize [:api, :v1, @document]
    if @document.save
      @signature_keys = @document.send_to_signing_platform_and_get_keys
      render :show, status: :created
    else
      render_error
    end

    # # Teste
    # @document = Document.new()
    # authorize [:api, :v1, @document]
    # @response = [{:email=>"joaquim.oliveira.nt@gmail.com", :signature_key=>"53e7a076-d8bc-4d9f-9c69-ae4fb0058fec"}]
    # render :show, status: :created
    # rescue
    #   render_error
  end

  # private
  #TODO instead of using resquest.body.read, use params. This will allow us to verify the content of the json received
  # def document_params
  #   params.require(:document).permit!
  # end

end
