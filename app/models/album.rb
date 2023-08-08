class Album < ApplicationRecord
  include Imageable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [[:name], [:name, Time.now.to_date]]
  end

  validates :name, presence: true

  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_attached_file :cover, styles: { thumb: '800x800#', index_1: '360x250#', index_2: '360x515#' },
                            convert_options: { thumb: '-quality 50', index_1: '-quality 50', index_2: '-quality 50', original: '-quality 70'}

  validates_attachment :cover, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end
