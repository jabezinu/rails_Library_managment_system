class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.references :category, null: false, foreign_key: true
      t.boolean :available

      t.timestamps
    end
  end
end
