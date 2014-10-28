UserAuth::Application.routes.draw do

  get 'orders/new'

  get 'bookings/new'

  get 'bookings/index'

  #get ':controller(/:action(/:id))(.:format)'
  
  resources :users,:movies,:centers,:adminlogins,:admins,:feedbacks, :films,:trailers,:news
  resources :sessions
  resources :bookings
  resources :films
  resources :pages
  resources :orders
  #connect ':controller/:action.:format '
  root :to => 'sessions#login'
  

  match "/signup", :to => "users#new", :via => [:get]
  match "/login", :to => "sessions#login", :via => [:get]
  match "/logout", :to => "sessions#logout", :via => [:get]
  match "/home", :to => "pages#home", :via => [:get]
  match "/profile", :to => "sessions#profile", :via => [:get]
  match "/setting", :to => "sessions#setting", :via => [:get]
  match "/login_attempt", to: "sessions#login_attempt", :via => [:post]
  match '/sample', to: 'bookings#sample', :via => [:get]
  match "/movienews", :to => "pages#news", :via => [:get]
  match "/movie_trailer", :to => "pages#trailer", :via => [:get]
  match "/admin_profile", :to => "adminlogin#admin_profile", :via => [:get]
  match "/admin_login", :to => "adminlogins#login", :via => [:get]
  match "/admin_logout", :to => "adminlogins#logout", :via => [:get]
  match "/feedback_rating", :to => "pages#feedback", :via => [:get]
  match "/aboutus", :to => "pages#aboutus", :via => [:get]
  match "/contact", :to => "pages#contact", :via => [:get]
  match "/film_details", :to => "pages#film", :via => [:get]
  match "/admin_login_attempt", to: "adminlogins#admin_login_attempt", :via => [:post]
  get 'bookings/update_cities', as: 'update_cities'
  get 'bookings/show'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
