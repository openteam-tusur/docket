class IntakesController < InheritedResources::Base
  actions :index, :edit, :update, :destroy

  belongs_to :plan do
    belongs_to :stream, :optional => true do
      belongs_to :degree, :optional => true
    end
  end

  has_scope :by_tuition

  def update
    update! { plan_scoped_intakes_path(@plan, :by_tuition => @intake.tuition) }
  end

  def destroy
    destroy! { plan_scoped_intakes_path(@plan, :by_tuition => @intake.tuition) }
  end
end

