json.extract! audio_record, :id, :b64field, :user_id, :created_at, :updated_at
json.url audio_record_url(audio_record, format: :json)
