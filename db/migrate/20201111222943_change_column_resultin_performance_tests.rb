class ChangeColumnResultinPerformanceTests < ActiveRecord::Migration[6.0]
  def change
    change_column :performance_tests, :result, :float
  end
end
