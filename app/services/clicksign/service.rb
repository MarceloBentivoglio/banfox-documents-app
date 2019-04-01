module Clicksign
  class Service
    def initialize
      @url = set_url
    end

    def set_url
      if Rails.env.development?
        "https://sandbox.clicksign.com/api/v1/documents?access_token=#{access_token}"
      elsif Rails.env.production?
        "https://sandbox.clicksign.com/api/v1/documents?access_token=#{access_token}"
      end
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
