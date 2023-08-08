class CarDecorator < Draper::Decorator
  delegate_all

  def full_name
    [object.mark&.name, object.model&.name].compact.join(' ')
  end

  def full_desc
    [
      object.year,
      loc_fuel_type,
      object.drive_type,
      loc_mileage
    ].compact.join(' / ')
  end

  def model_name
    object.model.name
  end

  def model_slug
    object.model.slug
  end

  def loc_fuel_type
    I18n.t("fuel_type.#{object.fuel_type}")
  end

  def loc_mileage
    h.number_to_km(object.mileage)
  end

  def popup_description
    "<h4>#{full_name}</h4><p>#{object.year} | #{object.drive_type} | #{object.engine_capacity} | #{loc_fuel_type} | #{loc_mileage}</p>"
  end

  def excise_fee_text
    begin
      case object.fuel_type
      when 'petrol'
        if object.engine_capacity < 3.0
          'Бензин < 3000 см3 = 50 $'
        else
          'Бензин > 3000 см3 = 100 $'
        end

      when 'gas'
        if object.engine_capacity < 3.0
          'Газ < 3000 см3 = 50 $'
        else
          'Газ > 3000 см3 = 100 $'
        end

      when 'gas_petrol'
        if object.engine_capacity < 3.0
          'Газ / Бензин < 3000 см3 = 50 $'
        else
          'Газ / Бензин > 3000 см3 = 100 $'
        end

      when 'hybrid'
        if object.engine_capacity < 3.0
          'Гибрид < 3000 см3 = 50 $'
        else
          'Гибрид > 3000 см3 = 100 $'
        end

      when 'diesel'
        if object.engine_capacity < 3.5
          'Дизель < 3500 см3 = 75 $'
        else
          'Дизель > 3500 см3 = 150 $'
        end

      else
        '0 $ для электромобилей'
      end
    rescue
      ''
    end
  end

  def import_fee_text
    if object.fuel_type == 'electro'
      'Для электрокаров пошлина составляет 0 %.'
    else
      'Ввозная пошлина – 10 % от цены транспорта'
    end
  end

  def vat_fee_text
    if object.fuel_type == 'electro'
      'Электромобили освобождены от НДС до 2022 года'
    else
      '20% от стоимости включая пошлину'
    end
  end
end
