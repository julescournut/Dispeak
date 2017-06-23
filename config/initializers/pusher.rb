# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '356803'
Pusher.key = '4ce30a88ba48b2442267'
Pusher.secret = '8feb54f9d2e11c197f31'
Pusher.cluster = 'eu'
Pusher.logger = Rails.logger
Pusher.encrypted = true

