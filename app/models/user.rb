class User < ApplicationRecord
  # testing
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
         
  has_many :performance_tests
  # :dependent => :destroy
  has_many :students, through: :performance_tests
  has_many :test_types, through: :performance_tests
  
  validates :full_name, presence: true

  def self.from_google(uid:, email:, full_name:, avatar_url:)
    user = User.find_or_create_by(email: email) do |u|
      u.uid = uid
      u.full_name = full_name
      u.avatar_url = avatar_url
      u.password = SecureRandom.hex
    end
    user.update(uid: uid, full_name: full_name, avatar_url: avatar_url)
    user
  end
  
end