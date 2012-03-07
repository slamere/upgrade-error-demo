ActionController::Routing::Routes.draw do |map|
  map.resources :organizations
  map.root :controller => "organizations"
end
