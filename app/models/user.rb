class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :performance_tests
  has_many :students, through: :performance_tests
  has_many :test_types, through: :performance_tests
  
  validates :name, presence: true
  
end
