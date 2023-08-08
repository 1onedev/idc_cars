class CarsQuery
  def initialize(params: {})
    @params = params
  end

  def all
    @relation = Car.published

    apply_mark_filter
    apply_model_filter
    apply_year_filter
    apply_price_filter
    apply_fuel_type_filter
    apply_gearbox_type_filter
    apply_body_type_filter
    apply_color_filter
    apply_drive_type_filter
    apply_ordering

    @relation
  end

  private

  def apply_mark_filter
    return if @params[:mark].blank?

    @relation = @relation.where(mark: @params[:mark])
  end

  def apply_model_filter
    return if @params[:model].blank?

    @relation = @relation.where(model: @params[:model])
  end

  def apply_year_filter
    return if @params[:year_from].blank? && @params[:year_to].blank?

    @relation = @relation.where('year >= ?', @params[:year_from]) if @params[:year_from].present?
    @relation = @relation.where('year <= ?', @params[:year_to]) if @params[:year_to].present?
  end

  def apply_price_filter
    return if @params[:price_from].blank? && @params[:price_to].blank?

    @relation = @relation.where('price >= ?', @params[:price_from]) if @params[:price_from].present?
    @relation = @relation.where('price <= ?', @params[:price_to]) if @params[:price_to].present?
  end

  def apply_fuel_type_filter
    return if @params[:fuel_type].blank?

    @relation = @relation.where(fuel_type: @params[:fuel_type])
  end

  def apply_gearbox_type_filter
    return if @params[:gearbox_type].blank?

    @relation = @relation.where(gearbox_type: @params[:gearbox_type])
  end

  def apply_body_type_filter
    return if @params[:body_type].blank?

    @relation = @relation.where(body_type: @params[:body_type])
  end

  def apply_color_filter
    return if @params[:color].blank?

    @relation = @relation.where(color: @params[:color])
  end

  def apply_drive_type_filter
    return if @params[:drive_type].blank?

    @relation = @relation.where(drive_type: @params[:drive_type])
  end

  def apply_drive_type_filter
    return if @params[:drive_type].blank?

    @relation = @relation.where(drive_type: @params[:drive_type])
  end

  def apply_ordering
    @relation = case @params[:sorting]
                when 'date-asc'   then @relation.order(year: :asc)
                when 'date-desc'  then @relation.order(year: :desc)
                when 'price-asc'  then @relation.order(price: :asc)
                when 'price-desc' then @relation.order(price: :desc)
                else @relation.order(created_at: :desc)
                end
  end
end
