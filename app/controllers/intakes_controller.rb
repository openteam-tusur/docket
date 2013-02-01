class IntakesController < InheritedResources::Base
  actions :new, :create, :edit, :update
  belongs_to :degree

  def create
    create! { streams_path }
  end

  def update
    update! { streams_path }
  end
end

