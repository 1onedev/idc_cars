class CatalogController < BaseController
  def index
    @mark = Mark.find_by(slug: params[:mark])
    @model = Model.find_by(slug: params[:model])

    @all_cars = CarsQuery.new(params: filter_params).all
    @cars = @all_cars.page(params[:page]).per(12)

    @filter_marks = Mark.with_cars.order(name: :asc)
    @filter_models = @mark.present? ? Model.with_cars.where(mark_id: @mark.id).order(name: :asc) : Model.none
    @years_range = Car.years_range

    @fuel_types = Car.fuel_types.map {|k, v| [t("fuel_type.#{k}"), k]}
    @gearbox_types = Car.gearbox_types.map {|k, v| [t("gearbox_type.#{k}"), k]}
    @body_types = Car.body_types.map {|k, v| [t("body_type.#{k}"), k]}
    @drive_types = Car.drive_types.map {|k, v| [t("drive_type.#{k}"), k]}
    @sort_types = [
      ['Від старих до нових', 'date-asc'],
      ['Від нових до старих', 'date-desc'],
      ['Від дешевих до дорогих', 'price-asc'],
      ['Від дорогих до дешевих', 'price-desc']
    ]

    set_seo(load_page_seo)
  end

  private

  def filter_params
    result = params.permit(
      :mark, :model, :fuel_type, :year_from, :year_to, :price_from, :price_to,
      :gearbox_type, :drive_type, :body_type, :color, :sorting
    )

    result.merge!(mark: @mark) if @mark
    result.merge!(model: @model) if @model
    result
  end

  def load_page_seo
    title = case
            when ((@mark && @model) || @model)
              "Придбай #{@mark.name} #{@model.name} з Кореї. Авто в наявності та під замовлення"
            when @mark
              "Автомобілі #{@mark.name} з Кореї в наявності та під замовлення"
            else
              "Автомобілі з Кореї в наявності та під замовлення"
            end
    description = case
                  when ((@mark && @model) || @model)
                    "Придбати автомобіль марки #{@mark.name} #{@model.name} з Кореї. Приходь до нас в автосалон та вибирай найкращі пропозиції без очікування часу доставки та  оформлення документів. Багато автомобілів в Україні, вибери своє #{@model.name} вже сьогодні!"
                  when @mark
                    "Придбати автомобіль марки #{@mark.name} з Кореї. Приходь до нас в автосалон та вибирай найкращі пропозиції без очікування часу доставки та  оформлення документів. Багато автомобілів в Україні, вибери своє #{@mark.name} вже сьогодні!"
                  else
                    "Придбати автомобіль з Кореї. Приходь до нас в автосалон та вибирай найкращі пропозиції без очікування часу доставки та  оформлення документів. Багато автомобілів в Україні, вибери своє авто вже сьогодні!"
                  end

    OpenStruct.new(
      seo_title: title, 
      seo_description: description,
      image: '/favicon/ou.jpg'
    )
  end
end
