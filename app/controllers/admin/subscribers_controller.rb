class Admin::SubscribersController < Admin::BaseController
  def index
    @subscribers = Subscriber.order(created_at: :desc).page(params[:page]).per(50)

    Subscriber.unviewed.update_all(viewed: true)
  end

  def show
    @subscriber = load_subscriber
  end

  def new
    @subscriber = Subscriber.new
  end

  def edit
    @subscriber = load_subscriber
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      redirect_to [:admin, @subscriber], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@subscriber.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @subscriber = load_subscriber

    if @subscriber.update(subscriber_params)
      redirect_to [:admin, @subscriber], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@subscriber.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @subscriber = load_subscriber

    @subscriber.destroy

    redirect_to admin_subscribers_path, notice: 'Данные удалены.'
  end

  private

  def load_subscriber
    Subscriber.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
