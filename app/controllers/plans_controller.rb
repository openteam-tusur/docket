class PlansController < InheritedResources::Base
  actions :index, :show, :new, :create, :edit, :update, :destroy

  has_scope :sorted_by_year, :default => 1 do |controller, scope|
    scope.order(:year)
  end
end

