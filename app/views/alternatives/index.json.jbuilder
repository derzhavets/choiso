json.array!(@alternatives) do |alternative|
  json.extract! alternative, :id, :name, :proposed_by, :user_id
  json.url alternative_url(alternative, format: :json)
end
