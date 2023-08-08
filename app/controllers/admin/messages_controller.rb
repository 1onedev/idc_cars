class Admin::MessagesController < Admin::BaseController
  def index
    @messages = Message.order(created_at: :desc).page(params[:page]).per(30)

    Message.unviewed.update_all(viewed: true)
  end

  def show
    @message = load_message
  end

  def new
    @message = Message.new
  end

  def edit
    @message = load_message
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to [:admin, @message], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@message.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @message = load_message

    if @message.update(message_params)
      respond_to do |format|
        format.html { redirect_to [:admin, @message], notice: 'Данные сохранены.' }
        format.js { render :update_success, layout: false }
      end
    else
      respond_to do |format|
        format.html do 
          flash[:alert] = "Ошибка: #{@message.errors.full_messages.join(', ')}"
          render :edit
        end

        format.js { render :update_error, layout: false }
      end
    end
  end

  def destroy
    @message = load_message

    @message.destroy

    redirect_to admin_messages_path, notice: 'Данные удалены.'
  end

  private

  def load_message
    Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:name, :phone, :email, :text, :comment)
  end
end
