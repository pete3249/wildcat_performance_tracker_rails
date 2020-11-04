class CreatePerformanceTests < ActiveRecord::Migration[6.0]
  def change
    create_table :performance_tests do |t|
      t.string :notes
      t.string :result
      t.datetime :date_taken
      t.references :user, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :test_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
