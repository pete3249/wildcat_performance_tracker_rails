class PerformanceTest < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :test_type

  validates :result, :date_taken, presence: true
  validates :result, uniqueness: { scope: [:date_taken, :test_type, :user_id], message: "Performance test has already been recorded for this student."}

  def test_name
    self.test_type.name 
  end 
  
  def self.by_test_type(test_type)
    where(test_type: test_type)
  end 

  def self.latest
    order(date_taken: :desc).first
  end 

  def self.most_recent
    order(date_taken: :desc)
  end 
  
  def self.old
    order(date_taken: :asc)
  end

  def self.top_scores
    order("result DESC").limit(3)
  end 

  def self.top_sprinting_scores
    order("result ASC").limit(3)
  end 

  def self.filter_options(options)
    if options[:filter_by_type]
      results = self.by_test_type(options[:filter_by_type])
    else
      results = self.all
    end 

    if options[:sort] == "most_recent"
        results = results.most_recent
    elsif options[:sort] == "old"
        results = results.old
    end 
    results
  end

  def self.filter_tests(options)
    if options[:id] == "1" || options[:id] == "2"
        tests = self.top_scores
    elsif options[:id] == "3" || options[:id] == "4"
        tests = self.top_sprinting_scores
    end 
  end 

end
