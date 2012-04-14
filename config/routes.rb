ActionController::Routing::Routes.draw do |map|
  map.resources :projects do |project|
    project.resources :project_groups, :except => [:index], :name_prefix => ""
  end

  #map.resources :project_groups, :except => [:index], :path_prefix => 'projects/:project_id'
end