# encoding: utf-8

class Specialization < ActiveRecord::Base
  attr_accessible :budget, :pay_budget, :density, :passing_grade, :title, :department_id

  belongs_to :department
  belongs_to :intake

  delegate :abbr, :to => :department, :prefix => true
  delegate :title, :to => :department, :prefix => true

  validates_presence_of :budget, :department_id
  validates_uniqueness_of :title, :scope => [:department_id, :intake_id]

  after_create :set_title, :unless => :title?

  private
    def set_title
      update_attribute(:title, 'Без профиля')
    end
end

