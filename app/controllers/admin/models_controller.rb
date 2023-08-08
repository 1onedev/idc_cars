class Admin::ModelsController < Admin::BaseController
  def index
    @models = Model.order(name: :asc).search(params[:q]).page(params[:page]).per(20)
  end

  def show
    @model = load_model
  end

  def new
    @model = Model.new
  end

  def edit
    @model = load_model
  end

  def create
    @model = Model.new(model_params)

    if @model.save
      redirect_to [:admin, @model], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@model.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @model = load_model

    if @model.update(model_params)
      redirect_to [:admin, @model], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@model.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @model = load_model

    @model.destroy

    redirect_to admin_models_path, notice: 'Данные удалены.'
  end

  private

  def load_model
    Model.friendly.find(params[:id])
  end

  def model_params
    params.require(:model).permit(
      :mark_id,
      :name,
      :description,
      :text,
      :seo_title,
      :seo_description
    )
  end
end
