class IntakesController < InheritedResources::Base
  actions :new, :create, :edit, :update, :destroy

  belongs_to :plan do
    belongs_to :stream do
      belongs_to :degree
    end
  end

  def create
    create! { plan_path(@plan) }
  end

  def update
    update! { plan_path(@plan) }
  end

  def destroy
    destroy! { plan_path(@plan) }
  end
end

