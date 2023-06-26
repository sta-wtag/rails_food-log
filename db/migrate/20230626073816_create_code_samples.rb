class CreateCodeSamples < ActiveRecord::Migration[6.1]
  def change
    create_table :code_samples do |t|
      t.references :review, null: false, foreign_key: true
      t.text :code

      t.timestamps
    end
  end
end
