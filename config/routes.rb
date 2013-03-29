Docket::Application.routes.draw do
  mount API::Docket => '/'

  resources :plans,            :only => [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :faculties,      :only => [:index, :new, :create, :edit, :update, :destroy]
    resources :entrance_exams, :only => [:index, :new, :create, :edit, :update, :destroy]
    resources :sectors,        :only => [:index, :new, :create, :edit, :update, :destroy]
    resources :streams,        :only => [:new, :create, :edit, :update, :destroy] do
      resources :degrees,      :only => [] do
        resources :intakes,    :only => [:new, :create, :edit, :update, :destroy]
      end
    end
  end

  root :to => 'plans#index'
end
