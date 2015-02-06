class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :lession, index: true
      t.references :word, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
    add_index :references, [:lession_id, :word_id, :answer_id]
  end
end
