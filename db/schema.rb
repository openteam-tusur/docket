# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130131050134) do

  create_table "degrees", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "duration"
    t.integer  "stream_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "degrees", ["stream_id"], :name => "index_degrees_on_stream_id"

  create_table "degrees_entrance_exams", :id => false, :force => true do |t|
    t.integer "degree_id"
    t.integer "entrance_exam_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "abbr"
    t.integer  "plan_id"
  end

  create_table "entrance_exams", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "plan_id"
  end

  create_table "intakes", :force => true do |t|
    t.string   "year"
    t.string   "tuition"
    t.integer  "budget"
    t.integer  "price"
    t.integer  "stream_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "intakes", ["stream_id"], :name => "index_intakes_on_stream_id"

  create_table "plans", :force => true do |t|
    t.string   "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sectors", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "plan_id"
  end

  create_table "specializations", :force => true do |t|
    t.string   "title"
    t.integer  "passing_grade"
    t.float    "density"
    t.integer  "department_id"
    t.integer  "intake_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "specializations", ["department_id"], :name => "index_specializations_on_department_id"

  create_table "streams", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.integer  "sector_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "plan_id"
    t.string   "degree_title"
  end

  add_index "streams", ["sector_id"], :name => "index_streams_on_sector_id"

end
