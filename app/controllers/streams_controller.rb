class StreamsController < InheritedResources::Base
  actions :index

  has_scope :sorted_by_code, :default => 1 do |controller, scope|
    scope.order(:code)
  end
end
