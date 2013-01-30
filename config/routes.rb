Docket::Application.routes.draw do
  resources :departments
  resources :entrance_exams
  resources :intakes
  resources :sectors
  resources :specializations
  resources :streams

  root :to => 'streams#index'
end
