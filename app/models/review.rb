class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, length: { minimum: 5 }
  STARS  = [1, 2, 3, 4, 5]
  validates :stars, inclusion: { in: STARS, message: "Value between 1 and 5" }
  
  def self.total_reviews(movie_id)
    where(movie_id: movie_id).count
  end

end
