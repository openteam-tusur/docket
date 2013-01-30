Docket::Application.routes.draw do
  resources :streams, :only => [:index]

  root :to => 'streams#index'
end
