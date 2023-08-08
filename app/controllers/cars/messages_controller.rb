class Cars::MessagesController < ::BaseController
  layout false

  def create
    car = Car.friendly.find(params[:car_id])
    data = message_params.merge(title: "Запит на авто")
    
    Message.create!(data.merge(car: car))
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
