class Student < ApplicationRecord
    has_many :performance_tests
    has_many :users, through: :performance_tests
    has_many :test_types, through: :performance_tests

    validates :name, :grad_year, presence: true
    validates :name, uniqueness: { scope: [:grad_year], message: "and graduation year match an existing student"}

end
