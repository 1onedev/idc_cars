class Admin::MarksController < Admin::BaseController
  def index
    @marks = Mark.order(name: :asc).search(params[:q]).page(params[:page]).per(20)
  end

  def show
    @mark = load_mark
  end

  def new
    @mark = Mark.new
  end

  def edit
    @mark = load_model
  end

  def create
    @mark = Mark.new(mark_params)

    if @mark.save
      redirect_to [:admin, @mark], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@mark.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @mark = load_mark

    if @mark.update(mark_params)
      redirect_to [:admin, @mark], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@mark.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @mark = load_mark

    @mark.destroy

    redirect_to admin_marks_path, notice: 'Данные удалены.'
  end

  private

  def load_mark
    Mark.friendly.find(params[:id])
  end

  def mark_params
    params.require(:mark).permit(
      :name,
      :cover,
      :description,
      :text,
      :seo_title,
      :seo_description
    )
  end
end
