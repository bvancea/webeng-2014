class Group < ActiveRecord::Base
  belongs_to :user
  validates :owner_id, presence: true
  validates :name, presence: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :activities, dependent: :destroy
end
