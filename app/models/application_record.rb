class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  IMG_TYPES = /^image\/(jpeg|jpg|png|gif)$/

  IMG_SIZES = 0..5.megabytes
end
