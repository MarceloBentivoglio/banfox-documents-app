module Clicksign

  class Service
    def initialize(document)
      @document = document
      @document_key = nil
      @signers_keys = []
    end

    def create_document
      url = "#{host}#{create_documents_path}#{request_params}"
      body = {
        "document": {
          "path": "/#{@document.filename}",
          "content_base64": @document.to_base_64,
          "deadline_at": @documen.deadline,
          "auto_close": true,
          "locale": "pt-BR"
        }
      }
      serialized_response = RestClient.post(url, body, headers)
      response = JSON.parse(serialized_response).deep_symbolize_keys
      @document_key = response[:document][:key]
      puts @document_key
    end

    def create_signers
      @document.signers.each do |signer|
        create_signer(signer)
      end
    end

    def create_signer(signer)
      url = "#{host}#{create_signers_path}#{request_params}"
      body = {
        "signer": {
          "email": signer[:email],
          "phone_number": signer[:mobile],
          "auths": [
            "sms"
          ],
          "name": signer[:name],
          "documentation": signer[:documentation],
          "birthday": signer[:birthdate],
          "has_documentation": true
        }
      }
      serialized_response = RestClient.post(url, body, headers)
      response = JSON.parse(serialized_response).deep_symbolize_keys
      @signers_keys << {signer[:email].to_sym => response[:signer][:key]}
      puts @document_key
    end

    def add_signers_to_document

    end

    private

    def host
      Rails.env.development? ? 'https://sandbox.clicksign.com' : 'https://app.clicksign.com'
    end

    def create_documents_path
      "/api/v1/documents"
    end

    def create_signer_path
      "/api/v1/signers"
    end

    def request_params
      "?access_token=#{Rails.application.credentials[Rails.env.to_sym][:clicksign][:access_token]}"
    end

    def headers
      { content_type: :json, accept: :json }
    end

  end







    url = "https://sandbox.clicksign.com/api/v1/documents?access_token=#{access_token}"
    body =   {
                "document": {
                  "path": "/" + params[:filename],
                  "content_base64": params[:base64],
                  "auto_close": true,
                  "locale": "pt-BR",
                  "signers": [
                    {
                      "email": params[:client_email],
                      "sign_as": signature_type,
                      "auths": [
                        "sms"
                      ],
                      "name": params[:client_name],
                      "documentation": "123.321.123-40",
                      "birthday": "1983-03-31",
                      "has_documentation": true,
                      "send_email": true,
                      "phone_number": params[:phone_number],
                      "message": "Olá, por favor assine o documento."

                    }
                  ]
                }
              }.to_json

    headers = {:Content_Type => "application/json", :Accept => "application/json"}
    response = RestClient.post(url, body, headers)
    response_parsed = JSON.parse(response.body)

    @document = Document.new(document_params)
    @document.status = "running"
    @document.key = response_parsed["document"]["key"]
    @document.user = current_user
    @document.signature_type = signature_type
    @document.json_response = response
    authorize @document

end
