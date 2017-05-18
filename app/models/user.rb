require 'digest'
class User < ActiveRecord::Base
  before_save :encrypt_password
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  def has_password?(password_soumis)
    encrypted_password == encrypt(password_soumis)
  end
  
  def self.authenticate(name, submitted_password)
    user = find_by_name(name)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end