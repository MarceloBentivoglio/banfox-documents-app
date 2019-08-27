module D4Sign
  class Service
    def initialize(document)
      file = Tempfile.new([document.filename, ".pdf"])
      string_io = StringIO.new(document.to_pdf)

      file.binmode
      file.write string_io.read
      url = "https://secure.d4sign.com.br/api/v1/documents/1d1cc0c2-98a1-4339-819c-c0bb722a3560/upload?tokenAPI=live_effdf56dfcdbfc106f76f92aabba5febfa3bf312fd829b16bd1c6ff8a6282e55&cryptKey=live_crypt_EEf6XfZYARawupkF6GsRGCMlIX7znn5K"
      headers = {
        "Content-Type": "multipart/form-data;",
        "tokenAPI": "live_effdf56dfcdbfc106f76f92aabba5febfa3bf312fd829b16bd1c6ff8a6282e55"
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
