Dvm::Application.routes.draw do
  resources :campaigns

  get "denied/index"
  get "denied"   => "denied#index", :as => "denied"

  get "voucher/index"

  get "error/error"

  match 'batches/campaign/:id/download_report' => 'batches#download_report'  
  match 'batches/campaign/:id/reports' => 'batches#reports_of_campaign'
  match 'batches/campaign/:id/new' => 'batches#new_of_campaign'
  match 'batches/campaign/:id' => 'batches#of_campaign'
  match 'batches/download/:id' => 'batches#download'
  match 'batches/reports/:id' => 'batches#reports'
  resources :batches

  resources :companies

  root :to => "sessions#new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  get "vouchers" => "voucher#index", :as => "vouchers"
  post "vouchers/search" => "voucher#search"
  post "vouchers/show" => "voucher#show"
  get "vouchers/show" => "voucher#show"
  post "vouchers/save_report" => "voucher#save_report"
  match 'vouchers/consume/:voucher' => 'voucher#consume'

  post "users/filter" => "users#index"
  get "users/upload" => "users#upload_index"
  post "users/upload" => "users#upload"
  resources :users
  resources :sessions

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
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
  # match ':controller(/:action(/:id))(.:format)'
end
