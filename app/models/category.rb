class Category < ApplicationRecord
  has_many :prodcats, inverse_of: :category
  has_many :products, through: :prodcats

  #validates :title, presence: true

  accepts_nested_attributes_for :prodcats, allow_destroy: true

  accepts_nested_attributes_for :products, allow_destroy: true
end
