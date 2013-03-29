class SectorsController < InheritedResources::Base
  actions :index, :new, :create, :edit, :update, :destroy
  belongs_to :plan

  has_scope :sorted_by_title, :default => 1 do |controller, scope|
    scope.order(:title)
  end
end

