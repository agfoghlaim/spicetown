class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :status
      t.string :billing
      t.string :shipping
      t.decimal :cart_total, precision: 12, scale: 2
      t.boolean :paid, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
