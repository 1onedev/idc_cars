class CarsController < BaseController
  def show
    @car = Car.friendly.find(params[:id]).decorate

    if @car.deleted_at.present? 
      redirect_to "/catalog/#{@car.mark&.slug}", status: 301 # 301 redirect if car deleted
    end

    @promo_cars = Car.published.promo.where.not(id: @car.id).limit(5)

    load_slick_settings

    set_seo(load_page_seo)
  end

  private

  def load_page_seo
    title = "Придбай #{@car.decorate.full_name} з Кореї за #{helpers.number_to_usd @car.price} на сайті mysite.com"
    description = "Продається автомобіль #{@car.decorate.full_name} #{@car.year}. Дивись це і інші автомобілі з Кореї на  сайті mysite.com. Все автомобілі в наявності. Запрошуємо на перегляд."

    OpenStruct.new(
      seo_title: title, 
      seo_description: description,
      image: @car.cover.url(:show)
    )
  end
end
