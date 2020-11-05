class PerformanceTest < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :test_type

  validates :result, :date_taken, presence: true
  validates :result, uniqueness: { scope: [:date_taken, :test_type, :user_id], message: "Performance test has already been recorded for this student."}
  
end
