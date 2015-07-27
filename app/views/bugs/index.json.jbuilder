json.array!(@bugs) do |bug|
  json.extract! bug, :id, :id, :wid, :title
  json.url bug_url(bug, format: :json)
end
