Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#about'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks", passwords: 'users/passwords' }
  resources :chatrooms, param: :slug
  resources :messages
  # resources :games
  resources :pictures
  resources :memes
  resources :votes
  resources :chatroom_players
  get ':slug/waiting', to: "chatrooms#waiting"
  get ':slug/meme', to: "chatrooms#meme"
  get ':slug/vote', to: "chatrooms#vote"
  get ':slug/winner', to: "chatrooms#winner"
  get ':slug', to: 'chatrooms#show'
  post ':slug/addarnold', to: 'chatroom_players#addarnold'
  post ':slug/removearnold', to: 'chatroom_players#removearnold'
  post 'chatrooms/join', to: 'chatrooms#join'

  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

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
