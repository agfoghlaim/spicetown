class CreateOitems < ActiveRecord::Migration[5.2]
  def change
    create_table :oitems do |t|
      t.integer :weight
      t.decimal :total, precision: 12, scale: 2
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
