Rails.application.routes.draw do
  devise_for :admins

  namespace :admin do
    resources :albums
    resources :answers
    resources :cars
    resources :feedbacks
    resources :marks
    resources :messages
    resources :models
    resources :posts
    resource  :positions, only: :update
    resources :slides
    resources :subscribers

    root to: 'cars#index'

    namespace :ajax, defaults: { format: :js } do
      resources :models
    end

    resources :images, only: [:create, :destroy]

    delete 'delete_photos', to: "images#delete_photos"
  end

  namespace :ajax, defaults: { format: :js } do
    resources :models, only: :index
  end

  resources :albums, only: %i[index show]
  resources :cars, only: %i[index show] do
    scope module: :cars do
      resources :messages, only: :create
    end
  end

  # resources :catalog, controller: :catalog
  resources :messages, only: :create
  resources :posts, only: %i[index show]
  resources :subscribers, only: :create

  get 'catalog/', to: :catalog, controller: :catalog, action: :index
  get 'catalog/:mark/', to: :catalog, controller: :catalog, action: :index
  get 'catalog/:mark/:model', to: :catalog, controller: :catalog, action: :index

  controller :pages do
    get 'about', action: :about, as: :about
    get 'contacts', action: :contacts, as: :contacts
    get 'faq', action: :faq, as: :faq
  end

  root to: 'home#index'
end
