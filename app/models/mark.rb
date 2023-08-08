class Mark < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") if query.present? }

  def slug_candidates
    [[:name], [:name, Time.now.to_date]]
  end

  validates :name, presence: true

  scope :with_cars, -> { where.not(cars_count: 0) }

  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_many :models, dependent: :nullify, inverse_of: :mark
  has_many :cars, dependent: :nullify, inverse_of: :mark

  has_attached_file :cover, styles: { thumb: '800x800#' },
                            convert_options: { thumb: '-quality 50', original: '-quality 70'}

  validates_attachment :cover, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end
