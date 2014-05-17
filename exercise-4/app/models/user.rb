class User < ActiveRecord::Base

  VALID_PASSWORD = /[a-zA-Z0-9][a-zA-Z0-9_]*/

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :name, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, format: { with: VALID_PASSWORD, message: '%{value} is not a valid format: [A-Za-z0-9][A-Za-z0-9_]*'}

  has_many :groups, foreign_key: 'owner_id'

  has_many :memberships, dependent: :destroy
  has_many :assignments, :class_name => 'Group', through: :memberships

  has_and_belongs_to_many :activities

end