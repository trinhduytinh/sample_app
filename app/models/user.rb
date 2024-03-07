class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.model.validate_name}
  validates :email, presence: true,
            length: {maximum: Settings.model.validate_email}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
