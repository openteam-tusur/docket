class API::Docket < Grape::API
  prefix :api
  format :json

  resources :streams do
    desc 'Return streams'
    get do
      present Intake.filter(params), :with => API::Entities::Stream
    end
  end
end
