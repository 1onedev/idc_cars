class HomeController < BaseController
  def index
    @slides = Slide.all
    @promo_cars = Car.published.promo.limit(5)
    @posts = footer_posts
    @feedbacks = Feedback.order(created_at: :desc).limit(6)

    @filter_marks = Mark.with_cars.order(name: :asc)
    @years_range = Car.years_range
    @fuel_types = Car.fuel_types.map {|k, v| [t("fuel_type.#{k}"), k]}

    @images = Image.where(imageable_type: 'Album').sample(5)

    load_slick_settings

    set_seo(load_page_seo)
  end  

  private

  def load_page_seo
    OpenStruct.new(
      seo_title: 'Дешеві авто з Кореї в наявності та під замовлення', 
      seo_description: 'Ми кращий постачальник автомобілів з Кореї, автомобілі вже в Україні, вам не треба чекати місяцями на транспортування і оформлення документів. Заходи до нас в салон і вибери класне авто вже сьогодні!',
      image: '/favicon/ou.jpg'
    )
  end
end
