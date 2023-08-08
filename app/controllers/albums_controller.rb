class AlbumsController < BaseController
  def index
    @albums = Album.order(created_at: :desc).page(params[:page]).per(12)

    set_seo(load_page_seo)
  end

  def show
    @album = Album.friendly.find(params[:id])

    set_seo(@album)
  end

  private

  def load_page_seo
    OpenStruct.new(seo_title: 'Альбоми', seo_description: 'IDC | Пошук та доставка авто з Кореї! Великий вибір послуг та найкращі ціни! Послуга «Під ключ», Оптимальні варіанти, СТО, Ексклюзивність!', image: '/favicon/ou.jpg')
  end
end
