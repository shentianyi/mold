Rails.application.routes.draw do
  resources :mould_details
  get 'welcome/index'

  resources :images

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'welcome#index'


  devise_for :users, :controllers => {registrations: :user_registrations, sessions: 'users/sessions'}


  devise_scope :user do
    get '/users/sign_in'=>'users/sessions#new'
    get '/users/sign_out' => 'user_sessions#destroy'
    post '/user_sessions/locale' => 'user_sessions#locale'
    get '/user_sessions/new' => 'user_sessions#new'
    post '/user_sessions/' => 'user_sessions#create'
    get '/user_sessions/destroy' => 'user_sessions#destroy'
    delete '/api/user_sessions/' => 'user_sessions#destroy'
    post '/api/user_sessions/' => 'user_sessions#create'
    get '/user_sessions/finish_guide' => 'user_sessions#finish_guide'
  end


  resources :users

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
