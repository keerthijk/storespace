class Store < ApplicationRecord
  has_many :spaces

  after_create :reload

  validates :title, presence: true, uniqueness: true
  validates :city, presence: true
  validates :street, presence: true
end
