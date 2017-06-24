json.extract! message, :id, :body, :created_at, :updated_at
json.user do
  json.partial! 'users/user', user: message.user, as: :user 
end
json.url message_url(message, format: :json)
