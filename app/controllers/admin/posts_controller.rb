class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.where(deleted_at: nil).order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @post = load_post
  end

  def new
    @post = Post.new
  end

  def edit
    @post = load_post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to [:admin, @post], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@post.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @post = load_post

    if @post.update(post_params)
      redirect_to [:admin, @post], notice: 'Данные сохранены.'
    else
      flas[:alert] = "Ошибка: #{@post.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @post = load_post

    @post.update!(deleted_at: Time.zone.now)

    redirect_to admin_posts_path, notice: 'Данные удалены.'
  end

  private

  def load_post
    Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :name,
      :cover,
      :published,
      :description,
      :text,
      :seo_title,
      :seo_description,
      :put_to_ticker
    )
  end
end
