# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    Intake.tuition.values.each do |tuition|
      primary.item tuition, Intake.tuition_values[tuition], plan_scoped_intakes_path(@plan, :by_tuition => tuition)
    end
  end
end
