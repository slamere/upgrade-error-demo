ActionController::Routing::Routes.draw do |map|
  map.resources :organizations
  map.resources :activities
  map.root :controller => "organizations"
end
