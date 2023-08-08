class Admin::AlbumsController < Admin::BaseController
  def index
    @albums = Album.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @album = load_album.decorate
    @images = @album.images
  end

  def new
    @album = Album.new
  end

  def edit
    @album = load_album
    @images = @album.images.order(:created_at)
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to [:admin, @album], notice: 'Данные сохранены.'
    else
      flash[:alert] = "Ошибка: #{@album.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @album = load_album

    if @album.update(album_params)
      redirect_to [:admin, @album], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@album.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @album = load_album

    @album.destroy

    redirect_to admin_albums_path, notice: 'Данные удалены.'
  end

  private

  def load_album
    Album.friendly.find(params[:id])
  end

  def album_params
    params.require(:album).permit(
      :name,
      :cover,
      :description,
      :text,
      :seo_title,
      :seo_description
    )
  end
end
