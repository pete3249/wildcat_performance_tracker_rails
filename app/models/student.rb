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

    def self.filter_students(options)
        if options[:filter_by_year] == "2021"
            students = self.by_grad_year("2021")
        elsif options[:filter_by_year] == "2022"
            students = self.by_grad_year("2022")
        elsif options[:filter_by_year] == "2023"
            students = self.by_grad_year("2023")
        elsif options[:filter_by_year] == "2024"
            students = self.by_grad_year("2024") 
        end 
        students
    end 
   
end
