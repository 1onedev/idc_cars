class Admin::AnswersController < Admin::BaseController
  def index
    @answers = Answer.order(position: :asc)
  end

  def show
    @answer = load_answer
  end

  def new
    @answer = Answer.new
  end

  def edit
    @answer = load_answer
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to [:admin, @answer], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@answer.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @answer = load_answer

    if @answer.update(answer_params)
      redirect_to [:admin, @answer], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@answer.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @answer = load_answer

    @answer.destroy

    redirect_to admin_answers_path, notice: 'Данные удалены.'
  end

  private

  def load_answer
    Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:question, :text)
  end
end
