class PerformanceTest < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :test_type

  validates :result, :date_taken, presence: true
end
