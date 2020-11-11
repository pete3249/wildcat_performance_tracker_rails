class PerformanceTest < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :test_type

  validates :result, :date_taken, presence: true
  validates :result, uniqueness: { scope: [:date_taken, :test_type, :user_id], message: "Performance test has already been recorded for this student."}
  
  def self.by_test_type(test_type)
    where(test_type: test_type)
  end 

  def self.latest
    order(date_taken: :desc).first
  end 

  def self.most_recent
    order(date_taken: :desc)
  end 

  def self.oldest
    order(date_taken: :asc).first
  end
  
  def self.old
    order(date_taken: :asc)
  end

end
