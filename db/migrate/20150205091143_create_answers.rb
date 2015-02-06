class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :answer_1
      t.text :answer_2
      t.text :answer_3
      t.text :answer_4
      t.references :word, index: true

      t.timestamps null: false
    end
  end
end
