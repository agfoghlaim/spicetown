class Recipe < ApplicationRecord
  has_many :ingredients,inverse_of: :recipe, dependent: :destroy
  has_many :directions,inverse_of: :recipe, dependent: :destroy
  has_many :anyingredients,inverse_of: :recipe, dependent: :destroy
  has_many :products, through: :ingredients
  has_one_attached :recipeimg
 

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :anyingredients, reject_if: :all_blank, allow_destroy: true

  validates :title, :description, presence: true

  validate :image_ok

  private
  def image_ok
    if recipeimg.attached? && !recipeimg.content_type.in?(%w(image/jpeg image/png image/jpg))
      errors.add(:recipeimg, 'must be png or jpg')
    end
  end


end
