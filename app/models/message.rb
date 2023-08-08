class Message < ApplicationRecord
  belongs_to :car, optional: true

  scope :unviewed, -> { where(viewed: false) }
end
