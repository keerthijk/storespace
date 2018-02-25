class Space < ApplicationRecord
  belongs_to :store, counter_cache: :spaces_count, optional: true

  after_create :reload

  validates :title, presence: true, uniqueness: true
  validates :size, presence: true
  validates :price_per_day, presence: true
  validates :price_per_week, presence: true
  validates :price_per_month, presence: true

end
