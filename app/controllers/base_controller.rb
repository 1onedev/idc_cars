class BaseController < ApplicationController
  helper_method :footer_posts

  def footer_posts
    @footer_posts ||= Post.published.order(created_at: :desc)
  end

  private

  def load_slick_settings
    @promo_slick_settings = {
      "slidesToShow": 3,
      "responsive":[
        {"breakpoint": 1024,"settings":{"slidesToShow": 2}},
        {"breakpoint": 768,"settings":{"slidesToShow": 1}}
      ]
    }

    @posts_slick_settings = {
      "slidesToShow": 3,
      "responsive":[
        {"breakpoint": 1024,"settings":{"slidesToShow": 2}},
        {"breakpoint": 768,"settings":{"slidesToShow": 1}}
      ]
    }

    @feedbacks_slick_settings = {
      "slidesToShow": 2,
      "responsive":[
        {"breakpoint": 1024,"settings":{"slidesToShow": 2}},
        {"breakpoint": 768,"settings":{"slidesToShow": 1}}
      ]
    }
  end

  def set_seo(page)
    title = page&.seo_title.presence || page&.name
    description = page&.seo_description || page&.description 
    image = page.try(:image) || page&.cover.url

    set_meta_tags site: 'IDC',
                  title: title,
                  reverse: true,
                  description: description,
                  twitter: {
                              title: title,
                              description: description,
                              card: 'summary_large_image',
                              image: { _: image }
                            },
                  og: {
                        title: title,
                        description: description,
                        type: 'website',
                        url: request.original_url,
                        image: { _: image }
                      }
  end
end
