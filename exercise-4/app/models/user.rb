class User < ActiveRecord::Base
  has_many :groups, foreign_key: "owner_id"

  has_many :memberships, dependent: :destroy
  has_many :assignments, :class_name=>'Group', through: :memberships

  has_and_belongs_to_many :activities

  validates :username, presence: true
  validates :password, presence: true
  validates :name, presence: true
end