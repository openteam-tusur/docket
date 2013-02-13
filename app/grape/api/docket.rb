class API::Docket < Grape::API
  prefix :api
  format :json

  resources :streams do
    desc 'Return streams'
    get do
      present Intake.filter(params), :with => API::Entities::Stream
    end

    desc 'Search options'
    get :search_options do
      Intake.search_options
    end
  end
end
