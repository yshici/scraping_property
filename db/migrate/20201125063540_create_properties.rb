class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :title, null: false
      t.string :access, null: false
      t.string :price, null: false
      t.string :floor, null: false
      t.string :area, null: false
      t.string :stair, null: false
      t.string :deposit, null: false
      t.string :management, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :properties, [:title, :url],  unique: true
  end
end
