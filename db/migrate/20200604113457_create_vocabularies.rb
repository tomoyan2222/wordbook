class CreateVocabularies < ActiveRecord::Migration[6.0]
  def change
    create_table :vocabularies do |t|
      t.string :word
      t.string :meaning
      t.references :title, null: false, foreign_key: true

      t.timestamps
    end
  end
end
