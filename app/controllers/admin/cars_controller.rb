class Admin::CarsController < Admin::BaseController
  def index
    @cars = Car.where(deleted_at: nil)
               .order(created_at: :desc)
               .search(params[:q])
               .page(params[:page])
               .per(20)
  end

  def show
    @car = load_car.decorate
    @images = @car.images
  end

  def new
    @car = Car.new

    load_properties
  end

  def edit
    @car = load_car
    @images = @car.images.order(:created_at)

    load_properties
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to [:admin, @car], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@car.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @car = load_car

    if @car.update(car_params)
      redirect_to [:admin, @car], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@car.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @car = load_car

    @car.update!(deleted_at: Time.zone.now)

    redirect_to admin_cars_path, notice: 'Данные удалены.'
  end

  private

  def load_car
    Car.friendly.find(params[:id])
  end

  def load_properties
    @years_range = Car.years_range
    @vehicle_types = Car.vehicle_types.map {|k, v| [t("vehicle_type.#{k}"), k]}
    @body_types = Car.body_types.map {|k, v| [t("body_type.#{k}"), k]}
    @fuel_types = Car.fuel_types.map {|k, v| [t("fuel_type.#{k}"), k]}
    @gearbox_types = Car.gearbox_types.map {|k, v| [t("gearbox_type.#{k}"), k]}
    @drive_types = Car.drive_types.map {|k, v| [t("drive_type.#{k}"), k]}
    @colors = Car.colors.map {|k, v| [t("color.#{k}"), k]}.sort
    @label_statuses = Car.label_statuses.map {|k, v| [t("label_status.#{k}"), k]}
    @states = Car.states.map {|k, v| [t("state.#{k}"), k]}
    @engine_capacities = Car.engine_capacities
    @doors_numbers = Car.doors_numbers
    @seats_numbers = Car.seats_numbers
  end

  def car_params
    params.require(:car).permit(
      :rating_value,
      :review_count,
      :mark_id,
      :model_id,
      :name,
      :vin_code,
      :cover,
      :published,
      :description,
      :text,
      :price,
      :price_abroad,
      :promo,
      :in_ukraine,
      :vehicle_type,
      :body_type,
      :gearbox_type,
      :fuel_type,
      :drive_type,
      :color,
      :label_status,
      :state,
      :year,
      :mileage,
      :engine_capacity,
      :doors_number,
      :seats_number,
      :metallic,
      :power,
      :video,
      :slug,
      :import_fee,
      :excise_fee,
      :vat_fee,
      :private_fee_1,
      :private_fee_2,
      :private_fee_3,
      :private_fee_4,
      :private_fee_5,
      :result_fee,
      :seo_title,
      :seo_description
    )
  end
end
