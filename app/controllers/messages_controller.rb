class MessagesController < ::BaseController
  layout false

  def create
    car = Car.friendly.find(params[:car]) if params[:car].present?
    mes_params = car.present? ? message_params.merge(car: car) : message_params

    Message.create!(mes_params)
  end

  private

  def message_params
    params.require(:message).permit(:name, :phone, :email, :subject, :text, :title)
  end

  def custom_text
    # TODO: send message from search page
    data = JSON.parse(params[:custom_text]).deep_symbolize_keys
    'Пошук: ' << [
      data[:mark],
      data[:model],
      data[:fuel_type],
      data[:year_from],
      data[:year_to],
      data[:price_from],
      data[:price_to],
      data[:body_type],
      data[:gearbox_type],
      data[:drive_type]
    ].compact.join(', ')
  end
end
