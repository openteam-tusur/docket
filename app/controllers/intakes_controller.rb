class IntakesController < InheritedResources::Base
  actions :new, :create, :edit, :update
  belongs_to :degree
end
