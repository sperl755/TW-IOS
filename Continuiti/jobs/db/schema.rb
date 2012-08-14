# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110721173942) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "oauth_type", :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action",     :limit => 50
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
  end

  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "ads", :force => true do |t|
    t.string   "name"
    t.text     "html"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "location"
    t.boolean  "published",        :default => false
    t.boolean  "time_constrained", :default => false
    t.string   "audience",         :default => "all"
  end

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_count"
  end

  create_table "apis", :force => true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.text     "cover_letter"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "status",            :limit => 1, :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", :force => true do |t|
    t.string   "filename"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.integer  "size"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "thumbnail"
    t.integer  "parent_id"
  end

  create_table "award_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "award_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "award_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "awards", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "award_type_id"
  end

  add_index "awards", ["award_type_id"], :name => "index_awards_on_award_type_id"

  create_table "bids", :force => true do |t|
    t.integer  "job_id"
    t.integer  "application_id"
    t.float    "paid_amount"
    t.float    "fees"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_items", :force => true do |t|
    t.integer  "job_id"
    t.integer  "cart_id"
    t.float    "unit_price"
    t.integer  "quantity",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.text    "tips"
    t.string  "new_post_text"
    t.string  "nav_text"
    t.string  "ctype"
    t.boolean "active",        :default => false
  end

  create_table "categories_jobs", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "job_id"
  end

  create_table "certifications", :force => true do |t|
    t.string   "title"
    t.date     "award_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certifications", ["user_id"], :name => "index_certifications_on_user_id"

  create_table "choices", :force => true do |t|
    t.integer "poll_id"
    t.string  "description"
    t.integer "votes_count", :default => 0
  end

  create_table "clippings", :force => true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.string   "image_url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "favorited_count", :default => 0
  end

  add_index "clippings", ["created_at"], :name => "index_clippings_on_created_at"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.datetime "created_at",                                       :null => false
    t.integer  "commentable_id",                 :default => 0,    :null => false
    t.string   "commentable_type", :limit => 15, :default => "",   :null => false
    t.integer  "user_id",                        :default => 0,    :null => false
    t.integer  "recipient_id"
    t.text     "comment"
    t.string   "author_name"
    t.string   "author_email"
    t.string   "author_url"
    t.string   "author_ip"
    t.boolean  "notify_by_email",                :default => true
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["recipient_id"], :name => "index_comments_on_recipient_id"
  add_index "comments", ["user_id"], :name => "fk_comments_user"

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "company_url"
    t.text     "description"
    t.text     "mission_philosophy"
    t.text     "core_values"
    t.text     "what_we_look_for"
    t.string   "company_page_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies_locations", :id => false, :force => true do |t|
    t.integer  "company_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_followers", :force => true do |t|
    t.integer  "company_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_photos", :force => true do |t|
    t.integer  "company_id"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.text     "raw_post"
    t.text     "post"
    t.string   "banner_title"
    t.string   "banner_subtitle"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "job_id",                                  :null => false
    t.integer  "application_id",                          :null => false
    t.integer  "status",                     :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contractor_id"
    t.string   "title"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.integer  "end_contract_reason"
    t.integer  "ended_by"
    t.text     "end_employer_comment"
    t.text     "end_contractor_comment"
    t.boolean  "work_again_with_employer"
    t.boolean  "work_again_with_contractor"
  end

  create_table "cost_methods", :force => true do |t|
    t.string   "title"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string "name"
  end

  create_table "degrees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "educations", :force => true do |t|
    t.string   "country"
    t.string   "organization"
    t.string   "degree"
    t.string   "major"
    t.integer  "from_year"
    t.integer  "end_year"
    t.text     "description"
    t.date     "from_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.text     "activities"
  end

  create_table "endorsements", :force => true do |t|
    t.text     "description"
    t.integer  "endorser_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "job_title"
    t.string   "company_name"
    t.string   "relation_type"
    t.string   "years_relation"
  end

  add_index "endorsements", ["endorser_id", "user_id"], :name => "index_endorsements_on_endorser_id_and_user_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.integer  "metro_area_id"
    t.string   "location"
    t.boolean  "allow_rsvp",    :default => true
  end

  create_table "experience_functional_areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", :force => true do |t|
    t.string   "company_name"
    t.string   "company_url"
    t.string   "industry"
    t.string   "city"
    t.string   "title"
    t.integer  "from_month"
    t.integer  "from_year"
    t.integer  "end_month"
    t.integer  "end_year"
    t.boolean  "current"
    t.text     "description"
    t.date     "from_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "career_level_id"
    t.integer  "functional_area_id"
    t.integer  "country_id"
  end

  create_table "favorites", :force => true do |t|
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "favoritable_type"
    t.integer  "favoritable_id"
    t.integer  "user_id"
    t.string   "ip_address",       :default => ""
  end

  add_index "favorites", ["user_id"], :name => "fk_favorites_user"

  create_table "forums", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.integer "topics_count",     :default => 0
    t.integer "sb_posts_count",   :default => 0
    t.integer "position"
    t.text    "description_html"
    t.string  "owner_type"
    t.integer "owner_id"
  end

  create_table "friendship_statuses", :force => true do |t|
    t.string "name"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "friend_id"
    t.integer  "user_id"
    t.boolean  "initiator",            :default => false
    t.datetime "created_at"
    t.integer  "friendship_status_id"
  end

  add_index "friendships", ["friendship_status_id"], :name => "index_friendships_on_friendship_status_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "general_availabilities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "general_availabilities", ["user_id"], :name => "index_general_availabilities_on_user_id"

  create_table "homepage_features", :force => true do |t|
    t.datetime "created_at"
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.datetime "updated_at"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
  end

  create_table "industries", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries_jobs", :id => false, :force => true do |t|
    t.integer "industry_id"
    t.integer "job_id"
  end

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interests", ["user_id"], :name => "index_interests_on_user_id"

  create_table "invitations", :force => true do |t|
    t.string   "email_addresses"
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.string   "token"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "jobtype_id"
    t.string   "title"
    t.string   "description"
    t.string   "private_description"
    t.date     "task_start_date"
    t.date     "task_end_date"
    t.string   "your_time_estimate"
    t.float    "your_cost_estimate_per_hour"
    t.float    "your_estimated_expense_to_do_task"
    t.string   "total_cost_calculated"
    t.string   "vehicle"
    t.string   "action_chosen"
    t.boolean  "make_template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cost_method_id",                                 :default => 0
    t.integer  "time_unit_id"
    t.string   "cost_per_time_unit"
    t.string   "fixed_cost_amount"
    t.string   "average_expected_cost"
    t.string   "average_expected_time"
    t.string   "custom_quote_factors"
    t.string   "skills"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "industry_id"
    t.string   "company"
    t.integer  "expense_required"
    t.integer  "task_location_type_id"
    t.integer  "status",                            :limit => 1, :default => 1
    t.integer  "visible_status",                    :limit => 1, :default => 0
    t.float    "total_paid_amount",                              :default => 0.0
    t.text     "video"
    t.text     "company_description"
    t.string   "compensation"
    t.string   "duration"
    t.integer  "hours_per_week"
    t.text     "requirement_list"
    t.integer  "staffing_position_type_id"
    t.integer  "staffing_position_category_id"
    t.time     "task_start_time"
    t.time     "task_end_time"
    t.date     "task_on_date"
    t.time     "task_on_time"
    t.boolean  "task_duration_type"
  end

  create_table "jobs_locations", :id => false, :force => true do |t|
    t.integer  "job_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobtypes", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_items", :force => true do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.string   "location_name"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "latitude",      :precision => 15, :scale => 10
    t.decimal  "longitude",     :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.string   "contact_name"
  end

  create_table "medias", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "notes"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "memberships", :force => true do |t|
    t.string   "name"
    t.date     "from_date"
    t.date     "until_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metro_areas", :force => true do |t|
    t.string  "name"
    t.integer "state_id"
    t.integer "country_id"
    t.integer "users_count", :default => 0
  end

  create_table "moderatorships", :force => true do |t|
    t.integer "forum_id"
    t.integer "user_id"
  end

  add_index "moderatorships", ["forum_id"], :name => "index_moderatorships_on_forum_id"

  create_table "monitorships", :force => true do |t|
    t.integer "topic_id"
    t.integer "user_id"
    t.boolean "active",   :default => true
  end

  create_table "offerings", :force => true do |t|
    t.integer "skill_id"
    t.integer "user_id"
  end

  create_table "offices", :force => true do |t|
    t.integer  "company_id"
    t.string   "office_name"
    t.string   "telephone"
    t.string   "email"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opportunity_preferences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "cart_id"
    t.string   "ip_address"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "card_expires_on"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "express_token"
    t.string   "express_payer_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "published_as", :limit => 16, :default => "draft"
    t.boolean  "page_public",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "payer_id"
    t.integer  "receiver_id"
    t.integer  "payable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payable_type"
    t.float    "amount"
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "width"
    t.integer  "height"
    t.integer  "album_id"
    t.integer  "view_count"
  end

  add_index "photos", ["created_at"], :name => "index_photos_on_created_at"
  add_index "photos", ["parent_id"], :name => "index_photos_on_parent_id"

  create_table "plugin_schema_migrations", :id => false, :force => true do |t|
    t.string "plugin_name"
    t.string "version"
  end

  create_table "polls", :force => true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "votes_count", :default => 0
  end

  add_index "polls", ["created_at"], :name => "index_polls_on_created_at"
  add_index "polls", ["post_id"], :name => "index_polls_on_post_id"

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "raw_post"
    t.text     "post"
    t.string   "title"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "view_count",                    :default => 0
    t.integer  "contest_id"
    t.integer  "emailed_count",                 :default => 0
    t.integer  "favorited_count",               :default => 0
    t.string   "published_as",    :limit => 16, :default => "draft"
    t.datetime "published_at"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["published_as"], :name => "index_posts_on_published_as"
  add_index "posts", ["published_at"], :name => "index_posts_on_published_at"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",                            :null => false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        :default => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "referral_bonus", :force => true do |t|
    t.float    "percent"
    t.integer  "maximum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "maximum_per_user"
  end

  create_table "referrals", :force => true do |t|
    t.integer  "referrer_id"
    t.integer  "referred_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "expired",     :default => false
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "rsvps", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "attendees_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sb_posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
    t.text     "body_html"
  end

  add_index "sb_posts", ["forum_id", "created_at"], :name => "index_sb_posts_on_forum_id"
  add_index "sb_posts", ["user_id", "created_at"], :name => "index_sb_posts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "sessid"
    t.text     "data"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "sessions", ["sessid"], :name => "index_sessions_on_sessid"

  create_table "skills", :force => true do |t|
    t.string "name"
  end

  create_table "staffing_position_categories", :force => true do |t|
    t.string   "title"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffing_position_types", :force => true do |t|
    t.string   "title"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string "name"
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["taggable_id"], :name => "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_type"], :name => "index_taggings_on_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "task_locations", :force => true do |t|
    t.integer  "job_id"
    t.string   "address_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "country_id"
    t.string   "phone"
    t.string   "contact_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_location_type_id", :default => 0
  end

  create_table "time_units", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",           :default => 0
    t.integer  "sticky",         :default => 0
    t.integer  "sb_posts_count", :default => 0
    t.datetime "replied_at"
    t.boolean  "locked",         :default => false
    t.integer  "replied_by"
    t.integer  "last_post_id"
  end

  add_index "topics", ["forum_id", "replied_at"], :name => "index_topics_on_forum_id_and_replied_at"
  add_index "topics", ["forum_id", "sticky", "replied_at"], :name => "index_topics_on_sticky_and_replied_at"
  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"

  create_table "user_descriptions", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_descriptions", ["user_id"], :name => "index_user_descriptions_on_user_id"

  create_table "user_files", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_files", ["attachable_id", "attachable_type"], :name => "index_user_files_on_attachable_id_and_attachable_type"

  create_table "user_general_availabilities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "general_availability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_opportunity_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "opportunity_preference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_opportunity_preferences", ["user_id", "opportunity_preference_id"], :name => "uop_idx"

  create_table "user_skills", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "month_period"
    t.integer  "year_period"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_skills", ["user_id"], :name => "index_user_skills_on_user_id"

  create_table "user_transportation_accesses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_work_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.text     "description"
    t.integer  "avatar_id"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "persistence_token"
    t.text     "stylesheet"
    t.integer  "view_count",                                                         :default => 0
    t.boolean  "vendor",                                                             :default => false
    t.string   "activation_code",        :limit => 40
    t.datetime "activated_at"
    t.integer  "state_id"
    t.integer  "metro_area_id"
    t.string   "login_slug"
    t.boolean  "notify_comments",                                                    :default => true
    t.boolean  "notify_friend_requests",                                             :default => true
    t.boolean  "notify_community_news",                                              :default => true
    t.integer  "country_id"
    t.boolean  "featured_writer",                                                    :default => false
    t.datetime "last_login_at"
    t.string   "zip"
    t.date     "birthday"
    t.string   "gender"
    t.boolean  "profile_public",                                                     :default => true
    t.integer  "activities_count",                                                   :default => 0
    t.integer  "sb_posts_count",                                                     :default => 0
    t.datetime "sb_last_seen_at"
    t.integer  "role_id"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",                                                        :default => 0
    t.integer  "failed_login_count",                                                 :default => 0
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "account_type",                                                       :default => false
    t.decimal  "rating_average",                       :precision => 6, :scale => 2, :default => 0.0
    t.string   "name"
    t.string   "facebook_username"
    t.integer  "facebook_uid",           :limit => 8
    t.string   "locale"
    t.string   "website"
    t.string   "facebook_session_key"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "transportation_access"
    t.string   "work_type"
    t.integer  "facebook_friends_count"
    t.string   "twitter_screen_name"
    t.string   "oauth_secret"
    t.string   "oauth_token"
    t.integer  "twitter_friends_count"
  end

  add_index "users", ["activated_at"], :name => "index_users_on_activated_at"
  add_index "users", ["avatar_id"], :name => "index_users_on_avatar_id"
  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["featured_writer"], :name => "index_users_on_featured_writer"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["login_slug"], :name => "index_users_on_login_slug"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["vendor"], :name => "index_users_on_vendor"

  create_table "vehicles", :force => true do |t|
    t.string   "title"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "poll_id"
    t.integer  "choice_id"
    t.datetime "created_at"
  end

end
