class CreateAnyingredients < ActiveRecord::Migration[5.2]
  def change
    create_table :anyingredients do |t|
      t.string, :name
      t.belongs_to :recipe, foreign_key: true

      t.timestamps
    end
  end
end
