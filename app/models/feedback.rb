class Feedback < ApplicationRecord
  def unfilled_stars
    5 - stars
  end
end
