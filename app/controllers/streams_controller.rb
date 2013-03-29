class StreamsController < InheritedResources::Base
  actions :new, :create, :edit, :update, :destroy
  belongs_to :plan

  has_scope :sorted_by_code, :default => 1 do |controller, scope|
    scope.order(:code)
  end
end
