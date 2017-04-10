class Listing < ApplicationRecord
  belongs_to :user
  has_many :photos

  #必須項目
  validates :home_type, presence: true
  validates :pet_type, presence: true
  validates :pet_size, presence: true
  validates :breeding_years, presence: true

end
