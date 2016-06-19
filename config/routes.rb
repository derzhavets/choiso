Rails.application.routes.draw do
  
  root 'alternatives#index'
  
  resources :alternatives
  
  resources :strengths
  resources :weaknesses
  
  devise_for :users, :controllers => { :registrations => "user/registrations", :sessions => "sessions", :invitations => 'invitations'  }
  get 'my_friends', to: 'users#my_friends'
  resources :users, only: [:show]
  resources :friendships
  
  resources :requests
  
  resources :notifications, only: [:index] do
    collection do
      post :mark_as_read
      get :unread
    end
  end
  
  
  
  get 'show_proposals', to: 'proposals#show'
  
  resources :requests, only: [:index, :create]
  
  get 'welcome', to: 'welcome#start'
  
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  get 'mirror', to: 'mirror#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'users/:id/propose_alternatives', to: 'alternatives#propose', as: :propose_alternatives
  post 'add_proposal', to: 'alternatives#add_proposal'
  get 'show_examples', to: 'alternatives#show_examples'
  delete 'remove_proposal/:id/', to: 'alternatives#destroy_proposal', as: :remove_proposal

  # Example of named route that can be invoked with purchase_url(id: product.id)
  # get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

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
