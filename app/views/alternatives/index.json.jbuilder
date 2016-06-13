json.array!(@alternatives) do |alternative|
  json.extract! alternative, :id, :name, :proposer_id, :user_id
  json.url alternative_url(alternative, format: :json)
end
