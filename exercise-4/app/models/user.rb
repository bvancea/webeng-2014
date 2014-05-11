class User < ActiveRecord::Base
  has_many :groups, foreign_key: "owner_id"

  has_many :memberships, dependent: :destroy
  has_many :assignments, :class_name=>'Group', through: :memberships
end