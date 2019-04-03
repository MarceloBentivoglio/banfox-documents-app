json.signature_keys @signature_keys.each do |signature_key|
  json.extract! signature_key, :email, :signature_key
end
