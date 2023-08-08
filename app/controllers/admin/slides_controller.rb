class Admin::SlidesController < Admin::BaseController
  def index
    @slides = Slide.order(position: :asc)
  end

  def show
    @slide = load_slide
  end

  def new
    @slide = Slide.new
  end

  def edit
    @slide = load_slide
  end

  def create
    @slide = Slide.new(slide_params)

    if @slide.save
      redirect_to [:admin, @slide], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@slide.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @slide = load_slide

    if @slide.update(slide_params)
      redirect_to [:admin, @slide], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@slide.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @slide = load_slide

    @slide.destroy

    redirect_to admin_slides_path, notice: 'Данные удалены.'
  end

  private

  def load_slide
    Slide.find(params[:id])
  end

  def slide_params
    params.require(:slide).permit(
      :position,
      :image,
      :first_title,
      :second_title,
      :button_title,
      :button_url
    )
  end
end
