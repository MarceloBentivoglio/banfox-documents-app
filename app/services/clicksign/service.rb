module Clicksign

  class Service
    attr_reader :request_signature_keys
    attr_reader :signer_keys
    attr_reader :document_key

    def initialize(document)
      @document = document
      @document_key = nil
      @signer_keys = []
      @request_signature_keys = []
    end

    def run
      create_document
      create_signers
      add_signers_to_document
    end

    def keys
      {
        document_key: @document_key,
        request_signature_keys: @request_signature_keys,
      }
    end


    private

    def create_document
      url = "#{host}/api/v1/documents#{request_params}"
      body = {
        "document": {
          "path": "/#{@document.filename}",
          "content_base64": "#{base64_prefix}#{@document.to_base_64}",
          "deadline_at": @document.deadline,
          "auto_close": true,
          "locale": "pt-BR"
        }
      }.to_json
      serialized_response = RestClient.post(url, body, header)
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
      url = "#{host}/api/v1/signers#{request_params}"
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
      }.to_json
      serialized_response = RestClient.post(url, body, header)
      response = JSON.parse(serialized_response).deep_symbolize_keys
      @signer_keys << { email: signer[:email], signer_key: response[:signer][:key] }
      puts @signer_keys
    end

    def add_signers_to_document
      @document.signers.each do |signer|
        signer[:sign_as].each do |sign_type|
          signer_key = @signer_keys.detect {|signer_key| signer_key[:email] == signer[:email]}.fetch(:signer_key)
          add_signer_to_document(signer[:email], signer_key , sign_type)
        end
      end
      puts @request_signature_keys
    end

    def add_signer_to_document(signer_email, signer_key, sign_type)
      url = "#{host}/api/v1/lists#{request_params}"
      body = {
        "list": {
          "document_key": @document_key,
          "signer_key": signer_key,
          "sign_as": sign_type
        }
      }.to_json
      serialized_response = RestClient.post(url, body, header)
      response = JSON.parse(serialized_response).deep_symbolize_keys
      new_signature_key = { email: signer_email, signature_key: response[:list][:request_signature_key] }
      unless @request_signature_keys.any? {|signature_key| signature_key[:email] == new_signature_key[:email]}
        @request_signature_keys << new_signature_key
      end
    end

    #TODO: trocar após o teste
    def host
      Rails.env.development? ? "https://sandbox.clicksign.com" : "https://app.clicksign.com"
    end

    # TODO this method doesn't work and I don't know why
    # def create_documents_path
    #   "api\/v1\/documents"
    # end

    # def create_signer_path
    #   "api\/v1\/signers"
    # end

    # def add_signers_to_document_path
    #   "api\/v1\/lists"
    # end

    #TODO: trocar credentials após o teste
    def request_params
      "?access_token=#{Rails.application.credentials[Rails.env.to_sym][:clicksign][:access_token]}"
    end

    def header
      {:Content_Type => "application/json", :Accept => "application/json"}
    end

    # This part is required by Clicksign
    def base64_prefix
      "data:application/pdf;base64,"
    end
  end

end
