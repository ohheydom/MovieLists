json.array!(@profiles) do |profile|
  json.extract! profile, :name, :genre
  json.url profile_url(profile, format: :json)
end
