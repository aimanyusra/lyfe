# json.array!(@events) do |event|
  # json.extract! event, :id, :title, :description, :start_date, :end_date, :location, :time, :age_limit, :price, :created_at, :updated_at
  json.id event.id
  json.title event.title
  json.start event.start_date
  json.end event.end_date
  json.update_url event_path(event, method: :patch)
  # json.url event_url(event, format: :html)
# end
