class Slide < ApplicationRecord
  default_scope { order(position: :asc) }

  after_destroy :delete_files!

  has_attached_file    :image,
                       styles: { thumb: '192x100#', index: '1920x1000#' },
                       convert_options: { thumb: '-quality 50', index: '-quality 75'}

  validates_attachment :image,
                       content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                       size: { in: 0..5.megabytes }

  def delete_files!
    return if Rails.env.development?

    styles = image.styles.keys.compact << :original
    styles.each do |style|
      begin
        image.s3_object(style).delete
      rescue
        next
      end
    end

    true
  end
end
