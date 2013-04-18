Docket::Application.routes.draw do
  mount API::Docket => '/'

  resources :plans,            :only => [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :faculties,      :only => [:index, :new, :create, :edit, :update, :destroy]
    resources :entrance_exams, :only => [:index, :new, :create, :edit, :update, :destroy]
    resources :sectors,        :only => [:index, :new, :create, :edit, :update, :destroy]
    get '/intakes/(:by_tuition)' => 'intakes#index', :constraints => { :by_tuition => Regexp.new(Intake.tuition.values.join('|')) }, :as => :scoped_intakes, :defaults => { :by_tuition => 'fulltime' }
    resources :streams,        :only => [:index, :new, :create, :edit, :update, :destroy] do
      resources :degrees,      :only => [] do
        resources :intakes,    :only => [:edit, :update, :destroy]
      end
    end
  end

  root :to => 'plans#index'
end
