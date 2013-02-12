class API::Entities::Stream < Grape::Entity
  expose :budget
  expose :price
  expose :tuition_text
  expose(:exams) { |model, options| model.entrance_exams.map(&:title) }
  expose(:degree) { |model, options| model.degree.as_json(:only => [:code, :duration, :title]) }
  expose :sector_title, :as => :sector
  expose(:stream) { |model, options| model.stream.as_json(:only => [:code, :title]) }

  expose(:specializations) { |model, options|
    model.specializations.map { |s|
      s.as_json(:only => [:density, :passing_grade, :title], :include => { :department => { :only => [:abbr, :title] } })
    }
  }
end

