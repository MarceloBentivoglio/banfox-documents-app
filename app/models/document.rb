class Document < ApplicationRecord
  belongs_to :user

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_file("tmp/#{filename}")
  end

  def to_base_64
    Base64.strict_encode64(to_pdf.read)
  end

  def filename
    "#{file_date} Aditivo da Operação #{individual_content[:operation][:id]}.pdf"
  end

  def render_attributes
    {
      template: "documents/pdf",
      layout: "pdf",
      locals: { document: individual_content }
    }
  end

  def individual_content
    variable_content.deep_symbolize_keys
  end

  def send_to_signing_platform_and_get_key
    clicksign_service = Clicksign::Service.new(self).run
    return clicksign_service.request_signature_keys
  end

  def deadline
    Time.parse(individual_content[:operation][:time]).change({hour: 23, min: 59}).iso8601
  end

  def signers
    individual_content[:signers]
  end


  private

  def file_date
    Time.parse(individual_content[:operation][:time]).strftime("%F")
  end

  def as_html
    ApplicationController.render(render_attributes)
  end

end
