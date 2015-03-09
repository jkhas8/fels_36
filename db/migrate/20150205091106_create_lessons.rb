class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :category, index: true
      t.references :user, index: true
      t.boolean :learned, default: false

      t.timestamps null: false
    end
    add_index :lessons, [:category_id, :user_id]
  end
end
