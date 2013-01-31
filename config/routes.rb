Docket::Application.routes.draw do
  resources :streams, :only => [:index]

  resources :degrees, :only => [:edit, :update]

  root :to => 'streams#index'
end
