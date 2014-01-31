json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :email, :phone
  json.url patient_url(patient, format: :json)
end
