class Image < ApplicationRecord
  default_scope { order(position: :asc) }

  belongs_to :imageable, polymorphic: true

  has_attached_file :file,
    styles: { thumb: '80x53#', show: '750x500#', promo: '350x500#', index_1: '360x250#', index_2: '360x515#' },
    convert_options: { thumb: '-quality 50', show: '-quality 70', promo: '-quality 70', index_1: '-quality 70', index_2: '-quality 70' }

  validates_attachment :file, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end
