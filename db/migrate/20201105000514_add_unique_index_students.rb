class AddUniqueIndexStudents < ActiveRecord::Migration[6.0]
  def change
    add_index :students, [:name, :grad_year], unique: true
  end
end
