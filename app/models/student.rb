class Student < ApplicationRecord
    has_many :performance_tests, :dependent => :destroy
    has_many :users, through: :performance_tests
    has_many :test_types, through: :performance_tests

    accepts_nested_attributes_for :performance_tests
    
    validates :name, :grad_year, presence: true
    validates :name, uniqueness: { scope: [:grad_year], message: "and graduation year match an existing student"}

    def self.by_grad_year(year)
        where(grad_year: year)
    end 

    def self.alphabetical
        order("name ASC")
    end 

    def self.filter_students(options)
        students = self.by_grad_year(options[:filter_by_year])
    end 

    def self.search_by_name(options)
        self.where("name LIKE ?", "%" + options + "%")
    end 
   
end
