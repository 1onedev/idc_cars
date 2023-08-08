class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [[:name], [:name, Time.now.to_date]]
  end

  validates :name, presence: true

  scope :published, -> { where(published: true, deleted_at: nil) }
  scope :put_to_ticker, -> { where(put_to_ticker: true) }

  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_attached_file :cover, styles: { thumb: '80x80#', slick: '350x233#' },
                            convert_options: { thumb: '-quality 50', slick: '-quality 70'}

  validates_attachment :cover, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end
