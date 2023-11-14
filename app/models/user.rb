class User < ApplicationRecord
  has_many :favorites, dependent: :destroy

  before_validation :generate_api_key, on: :create

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :api_key, presence: true, uniqueness: true

  has_secure_password

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(8)
      break unless User.exists?(api_key: api_key)
    end
  end
end