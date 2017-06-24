require 'digest'
class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation!
end