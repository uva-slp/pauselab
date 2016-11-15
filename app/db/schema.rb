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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161109171450) do

  create_table "blogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_blogs_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_ideas", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "idea_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "ideas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.text     "description",  limit: 16777215
    t.string   "location"
    t.integer  "likes",                         default: 0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "email"
    t.integer  "category_id"
    t.integer  "status",                    default: 0
  end

  create_table "proposals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cost"
    t.text     "description",            limit: 16777215
    t.string   "status",                                                 default: "unchecked"
    t.text     "essay",                  limit: 16777215
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.string   "website_link"
    t.integer  "user_id"
    t.string   "artist_cv_file_name"
    t.string   "artist_cv_content_type"
    t.integer  "artist_cv_file_size"
    t.datetime "artist_cv_updated_at"
    t.decimal  "artist_fees",                             precision: 10
    t.decimal  "project_materials",                       precision: 10
    t.decimal  "printing",                                precision: 10
    t.decimal  "marketing",                               precision: 10
    t.decimal  "documentation",                           precision: 10
    t.decimal  "volunteer",                               precision: 10
    t.decimal  "insurance",                               precision: 10
    t.decimal  "events",                                  precision: 10
    t.index ["user_id"], name: "index_proposals_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "phone"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
