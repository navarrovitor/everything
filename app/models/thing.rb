class Thing < ApplicationRecord
  has_many :points
  has_many :users, through: :points
end
