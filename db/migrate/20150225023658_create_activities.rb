class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true
      t.integer :target_id
      t.string :target_type
      t.integer :action_type

      t.timestamps null: false
    end
    add_index :activities, :created_at
  end
end
