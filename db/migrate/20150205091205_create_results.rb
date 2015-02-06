class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :lession, index: true
      t.references :word, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
  end
end
