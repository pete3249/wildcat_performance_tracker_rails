class TestType < ApplicationRecord
    has_many :performance_tests

    validates :name, presence: true, uniqueness: true
end
