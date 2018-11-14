class Point < ApplicationRecord
  belongs_to :user
  belongs_to :thing
end
