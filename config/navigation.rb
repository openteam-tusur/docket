# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :main, 'Главная страница', root_path

    primary.item :plan, "План набора #{@plan.year} года", plan_path(@plan), :highlights_on => /plan/ do |sub|
      sub.item :faculties, 'Факультеты', plan_faculties_path(@plan), :highlights_on => /facult/ do |inner|
        inner.item :new, 'Новый факультет', new_plan_faculty_path(@plan) if @faculty && @faculty.new_record?
        inner.item :edit, 'Редактирование факультета', edit_plan_faculty_path(@plan, @faculty) if @faculty && @faculty.persisted?
      end

      sub.item :sectors, 'Отрасли', plan_sectors_path(@plan), :highlights_on => /sector/ do |inner|
        inner.item :new, 'Новая отрасль', new_plan_sector_path(@plan) if @sector && @sector.new_record?
        inner.item :edit, 'Редактирование отрасли', edit_plan_sector_path(@plan, @sector) if @sector && @sector.persisted?
      end

      sub.item :entrance_exams, 'Вступительные испытания', plan_entrance_exams_path(@plan), :highlights_on => /entrance_exam/ do |inner|
        inner.item :new, 'Новое вступительное испытание', new_plan_entrance_exam_path(@plan) if @entrance_exam && @entrance_exam.new_record?
        inner.item :edit, 'Редактирование вступительного испытания', edit_plan_entrance_exam_path(@plan, @entrance_exam) if @entrance_exam && @entrance_exam.persisted?
      end
    end if @plan && @plan.persisted?
  end
end
