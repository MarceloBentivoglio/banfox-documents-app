json.extract! @keys, :document_key
json.signer_signature_keys @keys[:request_signature_keys].each do |signature_key|
  json.extract! signature_key, :email, :signature_key
end
