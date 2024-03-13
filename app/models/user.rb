class User < ApplicationRecord

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    # Find user by email, ignoring case
    user = User.where("LOWER(email) = ?", email.strip.downcase).first
    
    # Check if user exists and authenticate password
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
