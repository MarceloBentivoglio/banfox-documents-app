module D4Sign
  class Service
    def initialize(document)
      file = Tempfile.new([document.filename, ".pdf"])
      string_io = StringIO.new(document.to_pdf)

      file.binmode
      file.write string_io.read
      url = "http://demo.d4sign.com.br/api/v1/documents/fbc618e4-ed7e-4a87-b7d7-bc59a9477ce6/upload?tokenAPI=live_e29a3eb16705ad1125e740596478c6c5d93644fe72fbad587d00103fc1c067d1&cryptKey=live_crypt_y0hl7arZp0KBSAH1K1AiaUZ4w4uHqsIe"
      headers = {
        "Content-Type": "multipart/form-data;",
        "tokenAPI": "live_e29a3eb16705ad1125e740596478c6c5d93644fe72fbad587d00103fc1c067d1"
      }
      body = {
        "file": file,
      }
      begin
      response = RestClient.post(url, body, headers)
      rescue Exception => e
        byebug
      end
      return response
    end
  end
end
