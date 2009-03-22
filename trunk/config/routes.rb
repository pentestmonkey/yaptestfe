ActionController::Routing::Routes.draw do |map|
  map.resources :icmps

  map.resources :hosts_to_mac_addresses

  map.resources :mac_addresses

  map.resources :db

  map.resources :help

  map.resources :host_keys

  map.resources :topologys

  map.resources :host_info_keys

  map.resources :tablen

  map.resources :host_infos

  map.resources :port_keys

  map.resources :port_infos

  map.resources :test_areas

  map.resources :issues

  map.resources :port_summarys

  map.resources :insecure_protocols

  map.resources :password_hashs

  map.resources :credential_types

  map.resources :credentials

  map.resources :groups

  map.resources :transport_protocols

  map.resources :ports

  map.resources :hosts

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "hosts"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
