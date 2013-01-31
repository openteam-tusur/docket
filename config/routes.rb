Docket::Application.routes.draw do
  resources :streams, :only => [:index]

  resources :degrees, :only => [:edit, :update] do
    resources :intakes, :only => [:new, :edit, :update, :create]
  end

  root :to => 'streams#index'
end
