class CreateLessions < ActiveRecord::Migration
  def change
    create_table :lessions do |t|
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :lessions, [:category_id, :user_id]
  end
end
