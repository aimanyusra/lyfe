json.extract! event, :id, :title, :type, :description, :start_date, :end_date, :location, :time, :age_limit, :price, :created_at, :updated_at
json.url event_url(event, format: :json)
