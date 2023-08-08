class Admin::ImagesController < Admin::BaseController
  skip_before_action :authenticate_admin!, only: %i[create, delete_photos destroy]

  def create
    @image = Image.new(image_params)

    if @image.save!
      respond_to do |format|
        format.json { render json: { id: @image.id, image: @image.file.url(:show) } }
      end
    end
  end

  def delete_photos
    @images = Image.where(id: params[:images])
    @imageable = @images.last.imageable
    @images.destroy_all

    redirect_to [:admin, @imageable], notice: 'ОК'
  end

  def destroy
    @image = Image.find(params[:id])

    redirect_url = params[:redirect_url].presence || @image.imageable

    @image.destroy!

    redirect_to redirect_url, notice: 'ОК'
  end

  private

  def image_params
    params.permit(:file, :imageable_id, :imageable_type)
  end
end
