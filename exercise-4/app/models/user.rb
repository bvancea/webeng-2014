class User < ActiveRecord::Base
  has_many :groups, foreign_key: 'owner_id'

  has_many :memberships, dependent: :destroy
  has_many :assignments, :class_name => 'Group', through: :memberships

  has_and_belongs_to_many :activities

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 5 }
  validates :name, presence: true

end