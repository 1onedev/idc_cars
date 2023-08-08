class Admin::FeedbacksController < Admin::BaseController
  def index
    @feedbacks = Feedback.order(created_at: :desc)
  end

  def show
    @feedback = load_feedback
  end

  def new
    @feedback = Feedback.new
  end

  def edit
    @feedback = load_feedback
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to [:admin, @feedback], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@feedback.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @feedback = load_feedback

    if @feedback.update(feedback_params)
      redirect_to [:admin, @feedback], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@feedback.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @feedback = load_feedback

    @feedback.destroy

    redirect_to admin_feedbacks_path, notice: 'Данные удалены.'
  end

  private

  def load_feedback
    Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:name, :text, :stars)
  end
end
