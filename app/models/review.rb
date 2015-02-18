class Review < ActiveRecord::Base
  has_many :votes
end
