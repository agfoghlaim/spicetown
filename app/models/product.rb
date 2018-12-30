class Product < ApplicationRecord
  has_many :prodcats,inverse_of: :product, dependent: :destroy
  has_many :ingredients,inverse_of: :product, dependent: :destroy
  has_many :categories, through: :prodcats
  has_many :recipes, through: :ingredients
  has_many :oitems, dependent: :delete_all

  validates :title, presence: true
  

  accepts_nested_attributes_for :categories, allow_destroy: true
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  accepts_nested_attributes_for :prodcats, allow_destroy: true

  validates :title, :description, :price, presence: true
end
