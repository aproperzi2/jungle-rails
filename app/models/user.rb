class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }, presence: true
  validates :password, length: { minimum: 5 }
  validates :password_digest, presence: true
  
  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password.strip)
      return user
    else
      return nil
    end
  end
end
