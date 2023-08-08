class Car < ApplicationRecord
  FILTER_PARAMS = %i[
    fuel_type year_from year_to price_from price_to gearbox_type 
    drive_type body_type color sorting
  ].freeze

  include Imageable
  
  extend FriendlyId
  friendly_id :slug, use: :slugged

  scope :search, ->(query) { where("slug ILIKE ?", "%#{query}%") if query.present? }

  before_save { :set_slug }
  after_create { :set_ratings }

  belongs_to :mark, inverse_of: :cars, counter_cache: true
  belongs_to :model, inverse_of: :cars, counter_cache: true

  scope :published, -> { where('published = true AND deleted_at IS NULL') }
  scope :promo, -> { where('promo = true') }

  enum vehicle_type: {
    cars: 0, # Легковые
    moto: 1, # Мото
    trucks: 2, # Грузовики
    trailers: 3, # Прицепы
    special_equipment: 4, # Спецтехника
    agricultural_machinery: 5, # Сельхозтехника
    Buses: 6, # Автобусы
    water_transport: 7, # Водный транспорт
    air_transport: 8, # Воздушный транспорт
    motorhomes: 9, # Автодома
  }

  enum body_type: {
    sedan: 0, # Седан
    crossover: 1, # Внедорожник / Кроссовер
    minivan: 2, # Минивэн
    hatchback: 3, # Хэтчбек
    station_wagon: 4, # Универсал
    coupe: 5, # Купе
    light_van: 6, # Легковой фургон
    cabriolet: 7, # Кабриолет
    pickup: 8, # Пикап
    liftback: 9, # Лифтбек
    limousine: 10, # Лимузин
    roadster: 11, # Родстер
    compact_car: 12, #Компакт
    other_body: 13 # Другой
  }

  enum gearbox_type: {
    manual: 0, # Ручная / Механика
    automat: 1, # автомат
    robot: 2, # робот
    tiptronik: 3, # типтроник
    variator: 4 # вариатор
  }

  enum fuel_type: {
    petrol: 0, # бензин
    diesel: 1, # дизель
    gas: 2, # газ
    gas_petrol: 3, # газ / бензин
    hybrid: 4, # гибрид
    electro: 5, # электро
    other_fuel: 6 # другое
  }

  enum drive_type: {
    awd: 0, # полный
    fwd: 1, # полный
    rwd: 2 # полный
  }

  enum color: {
    beige: 0, # Бежевый
    black: 1, # Черный
    blue: 2, # Синий
    brown: 3, # Коричневый
    green: 4, # Зеленый
    gray: 5, # Серый
    orange: 6, # Орнажевый
    violet: 7, # Фиолетовый
    red: 8, # Красный
    white: 9, # Белый
    yellow: 10 # Желтый
  }

  enum label_status: {
    no_status: 0, # Без статуса
    in_stock: 1, # В наличии
    sales: 2, # Продано
    reservation: 3 # Резерв
  }

  enum state: {
    no_broken: 0, # Не бита
    broken: 1, # Бита
  }

  jsonb_accessor :state_fees, import_fee: [:integer, default: 0],
                              excise_fee: [:integer, default: 0],
                              vat_fee: [:integer, default: 0],
                              result_fee: [:integer, default: 0]

  jsonb_accessor :private_fees, private_fee_1: [:integer, default: 0],
                                private_fee_2: [:integer, default: 0],
                                private_fee_3: [:integer, default: 0],
                                private_fee_4: [:integer, default: 0],
                                private_fee_5: [:integer, default: 0]

  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def should_generate_new_friendly_id?
    slug.blank?
  end

  def set_slug
    if slug.blank? || model_id_changed? || mark_id_changed? || name_changed? || year_changed?
      self.slug = [mark.slug, model.slug, year, name&.downcase, 10.years.ago.to_i].compact.reject(&:blank?).join('-')
      self.seo_title = [mark.name, model.name, year, name&.downcase].compact.join(' ') if seo_title.blank?
    end
  end

  def self.engine_capacities
    (1..6).step(0.1).to_a.map { |v| v.round(1) }
  end

  def self.doors_numbers
    %w[1 2 3 4 5]
  end

  def self.seats_numbers
    %w[1 2 3 4 5 6 7]
  end

  def self.years_range
    (13.years.ago.year..Time.zone.now.year).to_a
  end

  has_attached_file :cover, styles: { thumb: '80x53#', show: '750x500#', promo: '350x500#' },
                            convert_options: { thumb: '-quality 50', show: '-quality 70', promo: '-quality 70' }

  validates_attachment :cover, content_type: { content_type: IMG_TYPES }, size: { in: IMG_SIZES }
end
