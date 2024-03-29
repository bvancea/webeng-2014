Rails.application.routes.draw do
  get 'welcome/index'

  get 'login/login'
  get 'login/logout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'login#login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  post 'login/login' => 'login#authenticate'
  get 'activities/show_all' => 'activities#show_all'
  get 'activities/show' => 'activities#show'
  post 'activities/delete' => 'activities#delete'
  post 'activities/edit' => 'activities#edit'
  post 'activities/vote' => 'activities#vote'
  post 'activities/unvote' => 'activities#unvote'
  post 'activities/make_definitive' => 'activities#make_definitive'
  get 'activities/search_images_on_flickr' => 'activities#search_images_on_flickr'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :users
  resources :groups
  resources :memberships
  resources :activities

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
