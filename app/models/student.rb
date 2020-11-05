class Student < ApplicationRecord
    has_many :performance_tests
    has_many :users, through: :performance_tests
    has_many :test_types, through: :performance_tests

    validates :first_name, :last_name, :grad_year, presence: true
    validates :first_name, uniqueness: { scope: [:last_name, :grad_year], message: "Cannot add student. Student already exists."}

end
