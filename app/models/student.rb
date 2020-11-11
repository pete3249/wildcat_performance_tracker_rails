class Student < ApplicationRecord
    has_many :performance_tests, :dependent => :destroy
    has_many :users, through: :performance_tests
    has_many :test_types, through: :performance_tests

    validates :name, :grad_year, presence: true
    validates :name, uniqueness: { scope: [:grad_year], message: "and graduation year match an existing student"}

    def self.by_grad_year(year)
        where(grad_year: year)
    end 

    def self.alphabetical
        order("name ASC")
    end 
   
end
