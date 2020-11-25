class Property < ApplicationRecord
  validates :title, presence: true
  validates :access, presence: true
  validates :price, presence: true
  validates :floor, presence: true
  validates :area, presence: true
  validates :stair, presence: true
  validates :url, presence: true
end
