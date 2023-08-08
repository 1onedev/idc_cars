class PostsController < BaseController
  def index
    @posts = Post.published.order(created_at: :desc).page(params[:page]).per(12)

    set_seo(load_page_seo)
  end

  def show
    @post = Post.friendly.find(params[:id])

    if @post.deleted_at.present? 
      redirect_to posts_path, status: 301 # 301 redirect if car deleted
    end

    @recent_posts = Post.published.where.not(id: @post.id).order(created_at: :desc).limit(4)

    @filter_marks = Mark.with_cars.order(name: :asc)
    @filter_models = Model.with_cars.order(name: :asc)

    set_seo(@post)
  end

  private
  def load_page_seo
    OpenStruct.new(seo_title: 'Статті', seo_description: 'IDC | Пошук та доставка авто з Кореї! Великий вибір послуг та найкращі ціни! Послуга «Під ключ», Оптимальні варіанти, СТО, Ексклюзивність!', image: '/favicon/ou.jpg')
  end
end
