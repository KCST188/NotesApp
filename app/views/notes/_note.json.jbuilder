json.extract! note, :id, :city, :note, :note_date, :temperature, :created_at, :updated_at
json.url note_url(note, format: :json)
