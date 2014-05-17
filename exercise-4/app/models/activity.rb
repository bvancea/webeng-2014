class Activity < ActiveRecord::Base
  belongs_to :group
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :location, length: { maximum: 50 }
  validates :group_id, presence: true
  validates :duration, numericality: true

  has_and_belongs_to_many :users
end
