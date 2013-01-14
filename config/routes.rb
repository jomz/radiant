Radiant::Engine.routes.draw do

  # Admin RESTful Routes
  namespace :admin do
    # member do
      # get => :remove
    # end
    
    resources :pages do
      resources :children, :controller => "pages"
    end
    resources :layouts
    resources :users
    
    match 'preview', :to => "admin/pages#preview", :via => [:put, :post]
    
    resource :preferences
    resource :configuration, :controller => 'configuration'
    resources :extensions, :only => :index
    resources :page_parts
    resources :page_fields
    
    match 'reference/:type.:format', :to => 'references#show', :via => [:get]
    
    controller :welcome do
      match 'welcome', :action => 'index'
      match 'login'
      match 'logout'
    end
  end
  
  controller :site do
    root :to => '#show_page', :url => '/'
    match 'error/404', :action => 'not_found', :as => 'not_found'
    match 'error/500', :action => 'error', :as => 'error'
    match ":url", :action => 'show_page', :as => 'connect'
  end

end
