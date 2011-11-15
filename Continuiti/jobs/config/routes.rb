ActionController::Routing::Routes.draw do |map|  
  map.resource :general_availabilities, :collection => {:index => :get, :new_custom_availability => :get, :save_new_custom_availability => :post}

  map.resources :award_types

  map.resources :endorsements, :collection => {:get_endorsement => :get, :send_invite_mail => :post}

  map.resources :memberships

  map.resources :interests

  map.resources :certifications

  map.resources :user_skills

  map.resources :user_files

  map.resources :staffing_position_categories

  map.resources :staffing_position_types

  map.resources :applications

  map.resources :degrees

  map.user_ratings 'rates/:user_id', :controller=>:rates, :action=>:index

  #XXX the below routes need to be namespaced within an 'admin' namespace somehow.
  map.resources :educations
  map.resources :award_users
  map.resources :awards, :collection => {:show_all_badges => :get, :show_all_available_badges_for_friend => :get, :new_badge_for_friend => :get, :share_badge_to_friend => :post, :get_a_badge => :get, :save_this_badge => :get}

  map.resources :jobs, :collection => [:temporary_jobs], :member =>[:invest_funds, :pay_to_users, :send_payments_to_users] #, :collection => {:update_visibility=>:get}

  map.search_skill_for_user "user_skills/suggestion/search_skill", :controller => :user_skills, :action => :search_skill, :conditions => {:method => :get}
  map.user_jobs_list_by_status 'j/:user_id/jobs/:status', :controller=>:jobs, :action=>:list
  map.show_job 'j/jobs/:title/:id', :controller=>:jobs, :action=>:show
  map.edit_job 'j/jobs/:title/:id/edit', :controller=>:jobs, :action=>:edit
  map.update_job_visibility 'jobs/:id/update_visibility', :controller=>:jobs, :action=>:update_visibility
  map.share_job 'share_job/:title/:id', :controller=>:jobs, :action=>:share_job
  map.job_applications 'job/:id/applications/:application_status', :controller=>:jobs, :action=>:job_applications
  map.send_application_message 'send_application_message', :controller => :applications, :action => :send_application_message, :conditions => {:method => :post}
  #map.job_apply 'j/job_apply/:job_id', :controller=>:jobs, :action=>:job_apply
  map.resources :applications
  map.new_application 'applications/new/:job_title/:job_id', :controller=>:applications, :action=>:new
  map.change_application_status 'application/:id/:new_status', :controller=>:applications, :action=>:change_application_status
  map.resources :contracts, :member=>[:activate, :employer_end]
  map.resources :contracts, :member=> {:rate => :post}
  map.contractor_end 'contractor_end/:id/:process_no', :controller=>:contracts, :action=>:contractor_end 
  map.resources :jobtypes
  map.resources :industries
  map.resources :time_units
  map.resources :cost_methods
  map.resources :vehicles
  map.resources :educations
  map.resources :user_session
  map.twitter_authenticate 'twitter_authenticate', :controller => :sessions, :action => :twitter_authenticate
  map.authenticate 'authenticate', :controller => :sessions, :action => :create, :conditions => {:method => :post} #:twitter_authenticate
  map.twitter_callback 'twitter_callback', :controller => :sessions, :action => :twitter_callback
  
  map.resources :users do |user|
    user.resources :companies, :member => [:follow, :unfollow], :collection =>[:search]
    user.resources :medias
    user.resource :opportunity_preferences, :collection => [:index]
    user.resource :user_descriptions, :except => :index
    user.resources :referrals, :only => [:index]
    user.resources :referral_bonus, :only => [:index, :update]
  end

  map.resources :carts,:only => [:show, :destroy]
  map.resources :cart_items, :only => [:create]
  map.resources :orders, :only => [:new, :create], :new => {:express => :get}
  
  #map.my_home '/', :controller => "sessions", :action => "new"
  #################### IPHONE API START ##################
  map.api_post_test 'api_post_test', :controller => :apis, :action => :test
  map.api_login 'api_login', :controller => :apis, :action => :login, :conditions=>{:method => :post}
  map.api_signup 'api_signup', :controller => :apis, :action => :signup, :conditions=>{:method => :post}
  map.resources :apis, :collection => {:job_list => :post, :search=>:get, :create_message=>:post, :fb_login=>:post}, :member=>{:job=>:post}
  
  #################### IPHONE API END ##################
  map.routes_from_plugin :community_engine

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'     
end
#== Route Map
# Generated on 06 Jun 2011 13:39
#
#                             applications GET    /applications(.:format)                                             {:action=>"index", :controller=>"applications"}
#                                          POST   /applications(.:format)                                             {:action=>"create", :controller=>"applications"}
#                                          GET    /applications/new(.:format)                                         {:action=>"new", :controller=>"applications"}
#                         edit_application GET    /applications/:id/edit(.:format)                                    {:action=>"edit", :controller=>"applications"}
#                                          GET    /applications/:id(.:format)                                         {:action=>"show", :controller=>"applications"}
#                                          PUT    /applications/:id(.:format)                                         {:action=>"update", :controller=>"applications"}
#                                          DELETE /applications/:id(.:format)                                         {:action=>"destroy", :controller=>"applications"}
#                                  degrees GET    /degrees(.:format)                                                  {:action=>"index", :controller=>"degrees"}
#                                          POST   /degrees(.:format)                                                  {:action=>"create", :controller=>"degrees"}
#                               new_degree GET    /degrees/new(.:format)                                              {:action=>"new", :controller=>"degrees"}
#                              edit_degree GET    /degrees/:id/edit(.:format)                                         {:action=>"edit", :controller=>"degrees"}
#                                   degree GET    /degrees/:id(.:format)                                              {:action=>"show", :controller=>"degrees"}
#                                          PUT    /degrees/:id(.:format)                                              {:action=>"update", :controller=>"degrees"}
#                                          DELETE /degrees/:id(.:format)                                              {:action=>"destroy", :controller=>"degrees"}
#                               educations GET    /educations(.:format)                                               {:action=>"index", :controller=>"educations"}
#                                          POST   /educations(.:format)                                               {:action=>"create", :controller=>"educations"}
#                            new_education GET    /educations/new(.:format)                                           {:action=>"new", :controller=>"educations"}
#                           edit_education GET    /educations/:id/edit(.:format)                                      {:action=>"edit", :controller=>"educations"}
#                                education GET    /educations/:id(.:format)                                           {:action=>"show", :controller=>"educations"}
#                                          PUT    /educations/:id(.:format)                                           {:action=>"update", :controller=>"educations"}
#                                          DELETE /educations/:id(.:format)                                           {:action=>"destroy", :controller=>"educations"}
#                              award_users GET    /award_users(.:format)                                              {:action=>"index", :controller=>"award_users"}
#                                          POST   /award_users(.:format)                                              {:action=>"create", :controller=>"award_users"}
#                           new_award_user GET    /award_users/new(.:format)                                          {:action=>"new", :controller=>"award_users"}
#                          edit_award_user GET    /award_users/:id/edit(.:format)                                     {:action=>"edit", :controller=>"award_users"}
#                               award_user GET    /award_users/:id(.:format)                                          {:action=>"show", :controller=>"award_users"}
#                                          PUT    /award_users/:id(.:format)                                          {:action=>"update", :controller=>"award_users"}
#                                          DELETE /award_users/:id(.:format)                                          {:action=>"destroy", :controller=>"award_users"}
#                                   awards GET    /awards(.:format)                                                   {:action=>"index", :controller=>"awards"}
#                                          POST   /awards(.:format)                                                   {:action=>"create", :controller=>"awards"}
#                                new_award GET    /awards/new(.:format)                                               {:action=>"new", :controller=>"awards"}
#                               edit_award GET    /awards/:id/edit(.:format)                                          {:action=>"edit", :controller=>"awards"}
#                                    award GET    /awards/:id(.:format)                                               {:action=>"show", :controller=>"awards"}
#                                          PUT    /awards/:id(.:format)                                               {:action=>"update", :controller=>"awards"}
#                                          DELETE /awards/:id(.:format)                                               {:action=>"destroy", :controller=>"awards"}
#                      temporary_jobs_jobs        /jobs/temporary_jobs(.:format)                                      {:action=>"temporary_jobs", :controller=>"jobs"}
#                                     jobs GET    /jobs(.:format)                                                     {:action=>"index", :controller=>"jobs"}
#                                          POST   /jobs(.:format)                                                     {:action=>"create", :controller=>"jobs"}
#                                  new_job GET    /jobs/new(.:format)                                                 {:action=>"new", :controller=>"jobs"}
#                                          GET    /jobs/:id/edit(.:format)                                            {:action=>"edit", :controller=>"jobs"}
#                         invest_funds_job        /jobs/:id/invest_funds(.:format)                                    {:action=>"invest_funds", :controller=>"jobs"}
#                         pay_to_users_job        /jobs/:id/pay_to_users(.:format)                                    {:action=>"pay_to_users", :controller=>"jobs"}
#               send_payments_to_users_job        /jobs/:id/send_payments_to_users(.:format)                          {:action=>"send_payments_to_users", :controller=>"jobs"}
#                                      job GET    /jobs/:id(.:format)                                                 {:action=>"show", :controller=>"jobs"}
#                                          PUT    /jobs/:id(.:format)                                                 {:action=>"update", :controller=>"jobs"}
#                                          DELETE /jobs/:id(.:format)                                                 {:action=>"destroy", :controller=>"jobs"}
#                 user_jobs_list_by_status        /j/:user_id/jobs/:status                                            {:action=>"list", :controller=>"jobs"}
#                                 show_job        /j/jobs/:title/:id                                                  {:action=>"show", :controller=>"jobs"}
#                                 edit_job        /j/jobs/:title/:id/edit                                             {:action=>"edit", :controller=>"jobs"}
#                    update_job_visibility        /jobs/:id/update_visibility                                         {:action=>"update_visibility", :controller=>"jobs"}
#                                          GET    /applications(.:format)                                             {:action=>"index", :controller=>"applications"}
#                                          POST   /applications(.:format)                                             {:action=>"create", :controller=>"applications"}
#                                          GET    /applications/new(.:format)                                         {:action=>"new", :controller=>"applications"}
#                                          GET    /applications/:id/edit(.:format)                                    {:action=>"edit", :controller=>"applications"}
#                                          GET    /applications/:id(.:format)                                         {:action=>"show", :controller=>"applications"}
#                                          PUT    /applications/:id(.:format)                                         {:action=>"update", :controller=>"applications"}
#                                          DELETE /applications/:id(.:format)                                         {:action=>"destroy", :controller=>"applications"}
#                          new_application        /applications/new/:job_title/:job_id                                {:action=>"new", :controller=>"applications"}
#                                 jobtypes GET    /jobtypes(.:format)                                                 {:action=>"index", :controller=>"jobtypes"}
#                                          POST   /jobtypes(.:format)                                                 {:action=>"create", :controller=>"jobtypes"}
#                              new_jobtype GET    /jobtypes/new(.:format)                                             {:action=>"new", :controller=>"jobtypes"}
#                             edit_jobtype GET    /jobtypes/:id/edit(.:format)                                        {:action=>"edit", :controller=>"jobtypes"}
#                                  jobtype GET    /jobtypes/:id(.:format)                                             {:action=>"show", :controller=>"jobtypes"}
#                                          PUT    /jobtypes/:id(.:format)                                             {:action=>"update", :controller=>"jobtypes"}
#                                          DELETE /jobtypes/:id(.:format)                                             {:action=>"destroy", :controller=>"jobtypes"}
#                               industries GET    /industries(.:format)                                               {:action=>"index", :controller=>"industries"}
#                                          POST   /industries(.:format)                                               {:action=>"create", :controller=>"industries"}
#                             new_industry GET    /industries/new(.:format)                                           {:action=>"new", :controller=>"industries"}
#                            edit_industry GET    /industries/:id/edit(.:format)                                      {:action=>"edit", :controller=>"industries"}
#                                 industry GET    /industries/:id(.:format)                                           {:action=>"show", :controller=>"industries"}
#                                          PUT    /industries/:id(.:format)                                           {:action=>"update", :controller=>"industries"}
#                                          DELETE /industries/:id(.:format)                                           {:action=>"destroy", :controller=>"industries"}
#                               time_units GET    /time_units(.:format)                                               {:action=>"index", :controller=>"time_units"}
#                                          POST   /time_units(.:format)                                               {:action=>"create", :controller=>"time_units"}
#                            new_time_unit GET    /time_units/new(.:format)                                           {:action=>"new", :controller=>"time_units"}
#                           edit_time_unit GET    /time_units/:id/edit(.:format)                                      {:action=>"edit", :controller=>"time_units"}
#                                time_unit GET    /time_units/:id(.:format)                                           {:action=>"show", :controller=>"time_units"}
#                                          PUT    /time_units/:id(.:format)                                           {:action=>"update", :controller=>"time_units"}
#                                          DELETE /time_units/:id(.:format)                                           {:action=>"destroy", :controller=>"time_units"}
#                             cost_methods GET    /cost_methods(.:format)                                             {:action=>"index", :controller=>"cost_methods"}
#                                          POST   /cost_methods(.:format)                                             {:action=>"create", :controller=>"cost_methods"}
#                          new_cost_method GET    /cost_methods/new(.:format)                                         {:action=>"new", :controller=>"cost_methods"}
#                         edit_cost_method GET    /cost_methods/:id/edit(.:format)                                    {:action=>"edit", :controller=>"cost_methods"}
#                              cost_method GET    /cost_methods/:id(.:format)                                         {:action=>"show", :controller=>"cost_methods"}
#                                          PUT    /cost_methods/:id(.:format)                                         {:action=>"update", :controller=>"cost_methods"}
#                                          DELETE /cost_methods/:id(.:format)                                         {:action=>"destroy", :controller=>"cost_methods"}
#                                 vehicles GET    /vehicles(.:format)                                                 {:action=>"index", :controller=>"vehicles"}
#                                          POST   /vehicles(.:format)                                                 {:action=>"create", :controller=>"vehicles"}
#                              new_vehicle GET    /vehicles/new(.:format)                                             {:action=>"new", :controller=>"vehicles"}
#                             edit_vehicle GET    /vehicles/:id/edit(.:format)                                        {:action=>"edit", :controller=>"vehicles"}
#                                  vehicle GET    /vehicles/:id(.:format)                                             {:action=>"show", :controller=>"vehicles"}
#                                          PUT    /vehicles/:id(.:format)                                             {:action=>"update", :controller=>"vehicles"}
#                                          DELETE /vehicles/:id(.:format)                                             {:action=>"destroy", :controller=>"vehicles"}
#                                          GET    /educations(.:format)                                               {:action=>"index", :controller=>"educations"}
#                                          POST   /educations(.:format)                                               {:action=>"create", :controller=>"educations"}
#                                          GET    /educations/new(.:format)                                           {:action=>"new", :controller=>"educations"}
#                                          GET    /educations/:id/edit(.:format)                                      {:action=>"edit", :controller=>"educations"}
#                                          GET    /educations/:id(.:format)                                           {:action=>"show", :controller=>"educations"}
#                                          PUT    /educations/:id(.:format)                                           {:action=>"update", :controller=>"educations"}
#                                          DELETE /educations/:id(.:format)                                           {:action=>"destroy", :controller=>"educations"}
#                       user_session_index GET    /user_session(.:format)                                             {:action=>"index", :controller=>"user_session"}
#                                          POST   /user_session(.:format)                                             {:action=>"create", :controller=>"user_session"}
#                         new_user_session GET    /user_session/new(.:format)                                         {:action=>"new", :controller=>"user_session"}
#                        edit_user_session GET    /user_session/:id/edit(.:format)                                    {:action=>"edit", :controller=>"user_session"}
#                             user_session GET    /user_session/:id(.:format)                                         {:action=>"show", :controller=>"user_session"}
#                                          PUT    /user_session/:id(.:format)                                         {:action=>"update", :controller=>"user_session"}
#                                          DELETE /user_session/:id(.:format)                                         {:action=>"destroy", :controller=>"user_session"}
#                           user_companies GET    /users/:user_id/companies(.:format)                                 {:action=>"index", :controller=>"companies"}
#                                          POST   /users/:user_id/companies(.:format)                                 {:action=>"create", :controller=>"companies"}
#                         new_user_company GET    /users/:user_id/companies/new(.:format)                             {:action=>"new", :controller=>"companies"}
#                        edit_user_company GET    /users/:user_id/companies/:id/edit(.:format)                        {:action=>"edit", :controller=>"companies"}
#                      follow_user_company        /users/:user_id/companies/:id/follow(.:format)                      {:action=>"follow", :controller=>"companies"}
#                    unfollow_user_company        /users/:user_id/companies/:id/unfollow(.:format)                    {:action=>"unfollow", :controller=>"companies"}
#                             user_company GET    /users/:user_id/companies/:id(.:format)                             {:action=>"show", :controller=>"companies"}
#                                          PUT    /users/:user_id/companies/:id(.:format)                             {:action=>"update", :controller=>"companies"}
#                                          DELETE /users/:user_id/companies/:id(.:format)                             {:action=>"destroy", :controller=>"companies"}
#                              user_medias GET    /users/:user_id/medias(.:format)                                    {:action=>"index", :controller=>"medias"}
#                                          POST   /users/:user_id/medias(.:format)                                    {:action=>"create", :controller=>"medias"}
#                           new_user_media GET    /users/:user_id/medias/new(.:format)                                {:action=>"new", :controller=>"medias"}
#                          edit_user_media GET    /users/:user_id/medias/:id/edit(.:format)                           {:action=>"edit", :controller=>"medias"}
#                               user_media GET    /users/:user_id/medias/:id(.:format)                                {:action=>"show", :controller=>"medias"}
#                                          PUT    /users/:user_id/medias/:id(.:format)                                {:action=>"update", :controller=>"medias"}
#                                          DELETE /users/:user_id/medias/:id(.:format)                                {:action=>"destroy", :controller=>"medias"}
#                                    users GET    /users(.:format)                                                    {:action=>"index", :controller=>"users"}
#                                          POST   /users(.:format)                                                    {:action=>"create", :controller=>"users"}
#                                 new_user GET    /users/new(.:format)                                                {:action=>"new", :controller=>"users"}
#                                edit_user GET    /users/:id/edit(.:format)                                           {:action=>"edit", :controller=>"users"}
#                                     user GET    /users/:id(.:format)                                                {:action=>"show", :controller=>"users"}
#                                          PUT    /users/:id(.:format)                                                {:action=>"update", :controller=>"users"}
#                                          DELETE /users/:id(.:format)                                                {:action=>"destroy", :controller=>"users"}
#                                     cart GET    /carts/:id(.:format)                                                {:action=>"show", :controller=>"carts"}
#                                          DELETE /carts/:id(.:format)                                                {:action=>"destroy", :controller=>"carts"}
#                               cart_items POST   /cart_items(.:format)                                               {:action=>"create", :controller=>"cart_items"}
#                                   orders POST   /orders(.:format)                                                   {:action=>"create", :controller=>"orders"}
#                                new_order GET    /orders/new(.:format)                                               {:action=>"new", :controller=>"orders"}
#                        express_new_order GET    /orders/new/express(.:format)                                       {:action=>"express", :controller=>"orders"}
#                       recent_forum_posts        /forums/recent                                                      {:action=>"index", :controller=>"sb_posts"}
#                                   forums GET    /forums(.:format)                                                   {:action=>"index", :controller=>"forums"}
#                                          POST   /forums(.:format)                                                   {:action=>"create", :controller=>"forums"}
#                                new_forum GET    /forums/new(.:format)                                               {:action=>"new", :controller=>"forums"}
#                               edit_forum GET    /forums/:id/edit(.:format)                                          {:action=>"edit", :controller=>"forums"}
#                                    forum GET    /forums/:id(.:format)                                               {:action=>"show", :controller=>"forums"}
#                                          PUT    /forums/:id(.:format)                                               {:action=>"update", :controller=>"forums"}
#                                          DELETE /forums/:id(.:format)                                               {:action=>"destroy", :controller=>"forums"}
#                                 sb_posts GET    /sb_posts(.:format)                                                 {:action=>"index", :controller=>"sb_posts"}
#                                          POST   /sb_posts(.:format)                                                 {:action=>"create", :controller=>"sb_posts"}
#                              new_sb_post GET    /sb_posts/new(.:format)                                             {:action=>"new", :controller=>"sb_posts"}
#                             edit_sb_post GET    /sb_posts/:id/edit(.:format)                                        {:action=>"edit", :controller=>"sb_posts"}
#                                  sb_post GET    /sb_posts/:id(.:format)                                             {:action=>"show", :controller=>"sb_posts"}
#                                          PUT    /sb_posts/:id(.:format)                                             {:action=>"update", :controller=>"sb_posts"}
#                                          DELETE /sb_posts/:id(.:format)                                             {:action=>"destroy", :controller=>"sb_posts"}
#                        monitorship_index GET    /monitorship(.:format)                                              {:action=>"index", :controller=>"monitorship"}
#                                          POST   /monitorship(.:format)                                              {:action=>"create", :controller=>"monitorship"}
#                          new_monitorship GET    /monitorship/new(.:format)                                          {:action=>"new", :controller=>"monitorship"}
#                         edit_monitorship GET    /monitorship/:id/edit(.:format)                                     {:action=>"edit", :controller=>"monitorship"}
#                              monitorship GET    /monitorship/:id(.:format)                                          {:action=>"show", :controller=>"monitorship"}
#                                          PUT    /monitorship/:id(.:format)                                          {:action=>"update", :controller=>"monitorship"}
#                                          DELETE /monitorship/:id(.:format)                                          {:action=>"destroy", :controller=>"monitorship"}
#                      search_all_sb_posts GET    /sb_posts/search(.:format)                                          {:action=>"search", :controller=>"sb_posts"}
#                   monitored_all_sb_posts GET    /sb_posts/monitored(.:format)                                       {:action=>"monitored", :controller=>"sb_posts"}
#                             all_sb_posts GET    /sb_posts(.:format)                                                 {:action=>"index", :controller=>"sb_posts"}
#                                          POST   /sb_posts(.:format)                                                 {:action=>"create", :controller=>"sb_posts"}
#                          new_all_sb_post GET    /sb_posts/new(.:format)                                             {:action=>"new", :controller=>"sb_posts"}
#                         edit_all_sb_post GET    /sb_posts/:id/edit(.:format)                                        {:action=>"edit", :controller=>"sb_posts"}
#                              all_sb_post GET    /sb_posts/:id(.:format)                                             {:action=>"show", :controller=>"sb_posts"}
#                                          PUT    /sb_posts/:id(.:format)                                             {:action=>"update", :controller=>"sb_posts"}
#                                          DELETE /sb_posts/:id(.:format)                                             {:action=>"destroy", :controller=>"sb_posts"}
#                           forum_sb_posts GET    /forums/:forum_id/sb_posts(.:format)                                {:action=>"index", :controller=>"sb_posts"}
#                                          POST   /forums/:forum_id/sb_posts(.:format)                                {:action=>"create", :controller=>"sb_posts"}
#                        new_forum_sb_post GET    /forums/:forum_id/sb_posts/new(.:format)                            {:action=>"new", :controller=>"sb_posts"}
#                       edit_forum_sb_post GET    /forums/:forum_id/sb_posts/:id/edit(.:format)                       {:action=>"edit", :controller=>"sb_posts"}
#                            forum_sb_post GET    /forums/:forum_id/sb_posts/:id(.:format)                            {:action=>"show", :controller=>"sb_posts"}
#                                          PUT    /forums/:forum_id/sb_posts/:id(.:format)                            {:action=>"update", :controller=>"sb_posts"}
#                                          DELETE /forums/:forum_id/sb_posts/:id(.:format)                            {:action=>"destroy", :controller=>"sb_posts"}
#                         forum_moderators GET    /forums/:forum_id/moderators(.:format)                              {:action=>"index", :controller=>"moderators"}
#                                          POST   /forums/:forum_id/moderators(.:format)                              {:action=>"create", :controller=>"moderators"}
#                      new_forum_moderator GET    /forums/:forum_id/moderators/new(.:format)                          {:action=>"new", :controller=>"moderators"}
#                     edit_forum_moderator GET    /forums/:forum_id/moderators/:id/edit(.:format)                     {:action=>"edit", :controller=>"moderators"}
#                          forum_moderator GET    /forums/:forum_id/moderators/:id(.:format)                          {:action=>"show", :controller=>"moderators"}
#                                          PUT    /forums/:forum_id/moderators/:id(.:format)                          {:action=>"update", :controller=>"moderators"}
#                                          DELETE /forums/:forum_id/moderators/:id(.:format)                          {:action=>"destroy", :controller=>"moderators"}
#                     forum_topic_sb_posts GET    /forums/:forum_id/topics/:topic_id/sb_posts(.:format)               {:action=>"index", :controller=>"sb_posts"}
#                                          POST   /forums/:forum_id/topics/:topic_id/sb_posts(.:format)               {:action=>"create", :controller=>"sb_posts"}
#                  new_forum_topic_sb_post GET    /forums/:forum_id/topics/:topic_id/sb_posts/new(.:format)           {:action=>"new", :controller=>"sb_posts"}
#                 edit_forum_topic_sb_post GET    /forums/:forum_id/topics/:topic_id/sb_posts/:id/edit(.:format)      {:action=>"edit", :controller=>"sb_posts"}
#                      forum_topic_sb_post GET    /forums/:forum_id/topics/:topic_id/sb_posts/:id(.:format)           {:action=>"show", :controller=>"sb_posts"}
#                                          PUT    /forums/:forum_id/topics/:topic_id/sb_posts/:id(.:format)           {:action=>"update", :controller=>"sb_posts"}
#                                          DELETE /forums/:forum_id/topics/:topic_id/sb_posts/:id(.:format)           {:action=>"destroy", :controller=>"sb_posts"}
#              new_forum_topic_monitorship GET    /forums/:forum_id/topics/:topic_id/monitorship/new(.:format)        {:action=>"new", :controller=>"monitorships"}
#             edit_forum_topic_monitorship GET    /forums/:forum_id/topics/:topic_id/monitorship/edit(.:format)       {:action=>"edit", :controller=>"monitorships"}
#                  forum_topic_monitorship GET    /forums/:forum_id/topics/:topic_id/monitorship(.:format)            {:action=>"show", :controller=>"monitorships"}
#                                          PUT    /forums/:forum_id/topics/:topic_id/monitorship(.:format)            {:action=>"update", :controller=>"monitorships"}
#                                          DELETE /forums/:forum_id/topics/:topic_id/monitorship(.:format)            {:action=>"destroy", :controller=>"monitorships"}
#                                          POST   /forums/:forum_id/topics/:topic_id/monitorship(.:format)            {:action=>"create", :controller=>"monitorships"}
#                             forum_topics GET    /forums/:forum_id/topics(.:format)                                  {:action=>"index", :controller=>"topics"}
#                                          POST   /forums/:forum_id/topics(.:format)                                  {:action=>"create", :controller=>"topics"}
#                          new_forum_topic GET    /forums/:forum_id/topics/new(.:format)                              {:action=>"new", :controller=>"topics"}
#                         edit_forum_topic GET    /forums/:forum_id/topics/:id/edit(.:format)                         {:action=>"edit", :controller=>"topics"}
#                              forum_topic GET    /forums/:forum_id/topics/:id(.:format)                              {:action=>"show", :controller=>"topics"}
#                                          PUT    /forums/:forum_id/topics/:id(.:format)                              {:action=>"update", :controller=>"topics"}
#                                          DELETE /forums/:forum_id/topics/:id(.:format)                              {:action=>"destroy", :controller=>"topics"}
#                                          GET    /forums(.:format)                                                   {:action=>"index", :controller=>"forums"}
#                                          POST   /forums(.:format)                                                   {:action=>"create", :controller=>"forums"}
#                                          GET    /forums/new(.:format)                                               {:action=>"new", :controller=>"forums"}
#                                          GET    /forums/:id/edit(.:format)                                          {:action=>"edit", :controller=>"forums"}
#                                          GET    /forums/:id(.:format)                                               {:action=>"show", :controller=>"forums"}
#                                          PUT    /forums/:id(.:format)                                               {:action=>"update", :controller=>"forums"}
#                                          DELETE /forums/:id(.:format)                                               {:action=>"destroy", :controller=>"forums"}
#                               forum_home        /forums                                                             {:action=>"index", :controller=>"forums"}
#                                   topics GET    /topics(.:format)                                                   {:action=>"index", :controller=>"topics"}
#                                          POST   /topics(.:format)                                                   {:action=>"create", :controller=>"topics"}
#                                new_topic GET    /topics/new(.:format)                                               {:action=>"new", :controller=>"topics"}
#                               edit_topic GET    /topics/:id/edit(.:format)                                          {:action=>"edit", :controller=>"topics"}
#                                    topic GET    /topics/:id(.:format)                                               {:action=>"show", :controller=>"topics"}
#                                          PUT    /topics/:id(.:format)                                               {:action=>"update", :controller=>"topics"}
#                                          DELETE /topics/:id(.:format)                                               {:action=>"destroy", :controller=>"topics"}
#                                 sessions GET    /sessions(.:format)                                                 {:action=>"index", :controller=>"sessions"}
#                                          POST   /sessions(.:format)                                                 {:action=>"create", :controller=>"sessions"}
#                              new_session GET    /sessions/new(.:format)                                             {:action=>"new", :controller=>"sessions"}
#                             edit_session GET    /sessions/:id/edit(.:format)                                        {:action=>"edit", :controller=>"sessions"}
#                                  session GET    /sessions/:id(.:format)                                             {:action=>"show", :controller=>"sessions"}
#                                          PUT    /sessions/:id(.:format)                                             {:action=>"update", :controller=>"sessions"}
#                                          DELETE /sessions/:id(.:format)                                             {:action=>"destroy", :controller=>"sessions"}
#                                                 /sitemap.xml                                                        {:action=>"index", :format=>"xml", :controller=>"sitemap"}
#                                                 /sitemap                                                            {:action=>"index", :controller=>"sitemap"}
#                                     home        /                                                                   {:action=>"site_index", :controller=>"base"}
#                              application        /                                                                   {:action=>"site_index", :controller=>"base"}
#                              admin_pages GET    /admin/pages(.:format)                                              {:action=>"index", :controller=>"pages"}
#                                          POST   /admin/pages(.:format)                                              {:action=>"create", :controller=>"pages"}
#                           new_admin_page GET    /admin/pages/new(.:format)                                          {:action=>"new", :controller=>"pages"}
#                          edit_admin_page GET    /admin/pages/:id/edit(.:format)                                     {:action=>"edit", :controller=>"pages"}
#                       preview_admin_page GET    /admin/pages/:id/preview(.:format)                                  {:action=>"preview", :controller=>"pages"}
#                               admin_page PUT    /admin/pages/:id(.:format)                                          {:action=>"update", :controller=>"pages"}
#                                          DELETE /admin/pages/:id(.:format)                                          {:action=>"destroy", :controller=>"pages"}
#                                    pages        /pages/:id                                                          {:action=>"show", :controller=>"pages"}
#                          admin_dashboard        /admin/dashboard                                                    {:action=>"index", :controller=>"homepage_features"}
#                              admin_users        /admin/users                                                        {:action=>"users", :controller=>"admin"}
#                           admin_messages        /admin/messages                                                     {:action=>"messages", :controller=>"admin"}
#                           admin_comments        /admin/comments                                                     {:action=>"comments", :controller=>"admin"}
#                               admin_tags        /admin/tags/:action                                                 {:controller=>"tags"}
#                             admin_events        /admin/events                                                       {:action=>"events", :controller=>"admin"}
#                                          GET    /admin/users(.:format)                                              {:action=>"index", :controller=>"admin/users"}
#                                          POST   /admin/users(.:format)                                              {:action=>"create", :controller=>"admin/users"}
#                           new_admin_user GET    /admin/users/new(.:format)                                          {:action=>"new", :controller=>"admin/users"}
#                          edit_admin_user GET    /admin/users/:id/edit(.:format)                                     {:action=>"edit", :controller=>"admin/users"}
#                          rate_admin_user POST   /admin/users/:id/rate(.:format)                                     {:action=>"rate", :controller=>"admin/users"}
#                               admin_user GET    /admin/users/:id(.:format)                                          {:action=>"show", :controller=>"admin/users"}
#                                          PUT    /admin/users/:id(.:format)                                          {:action=>"update", :controller=>"admin/users"}
#                                          DELETE /admin/users/:id(.:format)                                          {:action=>"destroy", :controller=>"admin/users"}
#                                   teaser        /                                                                   {:action=>"teaser", :controller=>"base"}
#                                    login        /login                                                              {:action=>"new", :controller=>"sessions"}
#                                   signup        /signup                                                             {:action=>"new", :controller=>"users"}
#                                   logout        /logout                                                             {:action=>"destroy", :controller=>"sessions"}
#                             signup_by_id        /signup/:inviter_id/:inviter_code                                   {:action=>"new", :controller=>"users"}
#                          forgot_password        /forgot_password                                                    {:action=>"forgot_password", :controller=>"users"}
#                          forgot_username        /forgot_username                                                    {:action=>"forgot_username", :controller=>"users"}
#                        resend_activation        /resend_activation                                                  {:action=>"resend_activation", :controller=>"users"}
#                                                 /new_clipping                                                       {:action=>"new_clipping", :controller=>"clippings"}
#                           site_clippings        /clippings                                                          {:action=>"site_index", :controller=>"clippings"}
#                       rss_site_clippings        /clippings.rss                                                      {:action=>"site_index", :format=>"rss", :controller=>"clippings"}
#                                 featured        /featured                                                           {:action=>"featured", :controller=>"posts"}
#                             featured_rss        /featured.rss                                                       {:action=>"featured", :format=>"rss", :controller=>"posts"}
#                                  popular        /popular                                                            {:action=>"popular", :controller=>"posts"}
#                              popular_rss        /popular.rss                                                        {:action=>"popular", :format=>"rss", :controller=>"posts"}
#                                   recent        /recent                                                             {:action=>"recent", :controller=>"posts"}
#                               recent_rss        /recent.rss                                                         {:action=>"recent", :format=>"rss", :controller=>"posts"}
#                             rss_redirect        /rss                                                                {:action=>"rss_site_index", :controller=>"base"}
#                                      rss        /site_index.rss                                                     {:action=>"site_index", :format=>"rss", :controller=>"base"}
#                                advertise        /advertise                                                          {:action=>"advertise", :controller=>"base"}
#                                 css_help        /css_help                                                           {:action=>"css_help", :controller=>"base"}
#                                    about        /about                                                              {:action=>"about", :controller=>"base"}
#                                      faq        /faq                                                                {:action=>"faq", :controller=>"base"}
#                  edit_account_from_email        /account/edit                                                       {:action=>"edit_account", :controller=>"users"}
#                          friendships_xml        /friendships.xml                                                    {:action=>"index", :format=>"xml", :controller=>"friendships"}
#                              friendships        /friendships                                                        {:action=>"index", :controller=>"friendships"}
#                            manage_photos        /manage_photos                                                      {:action=>"manage_photos", :controller=>"photos"}
#                             create_photo        /create_photo.js                                                    {:action=>"create", :format=>"js", :controller=>"photos"}
#                                          GET    /sessions(.:format)                                                 {:action=>"index", :controller=>"sessions"}
#                                          POST   /sessions(.:format)                                                 {:action=>"create", :controller=>"sessions"}
#                                          GET    /sessions/new(.:format)                                             {:action=>"new", :controller=>"sessions"}
#                                          GET    /sessions/:id/edit(.:format)                                        {:action=>"edit", :controller=>"sessions"}
#                                          GET    /sessions/:id(.:format)                                             {:action=>"show", :controller=>"sessions"}
#                                          PUT    /sessions/:id(.:format)                                             {:action=>"update", :controller=>"sessions"}
#                                          DELETE /sessions/:id(.:format)                                             {:action=>"destroy", :controller=>"sessions"}
#              activities_chart_statistics GET    /statistics/activities_chart(.:format)                              {:action=>"activities_chart", :controller=>"statistics"}
#                    activities_statistics GET    /statistics/activities(.:format)                                    {:action=>"activities", :controller=>"statistics"}
#                               statistics GET    /statistics(.:format)                                               {:action=>"index", :controller=>"statistics"}
#                                          POST   /statistics(.:format)                                               {:action=>"create", :controller=>"statistics"}
#                            new_statistic GET    /statistics/new(.:format)                                           {:action=>"new", :controller=>"statistics"}
#                           edit_statistic GET    /statistics/:id/edit(.:format)                                      {:action=>"edit", :controller=>"statistics"}
#                                statistic GET    /statistics/:id(.:format)                                           {:action=>"show", :controller=>"statistics"}
#                                          PUT    /statistics/:id(.:format)                                           {:action=>"update", :controller=>"statistics"}
#                                          DELETE /statistics/:id(.:format)                                           {:action=>"destroy", :controller=>"statistics"}
#                                     tags GET    /tags(.:format)                                                     {:action=>"index", :controller=>"tags"}
#                                          POST   /tags(.:format)                                                     {:action=>"create", :controller=>"tags"}
#                                  new_tag GET    /tags/new(.:format)                                                 {:action=>"new", :controller=>"tags"}
#                                 edit_tag GET    /tags/:id/edit(.:format)                                            {:action=>"edit", :controller=>"tags"}
#                                      tag GET    /tags/:id(.:format)                                                 {:action=>"show", :controller=>"tags"}
#                                          PUT    /tags/:id(.:format)                                                 {:action=>"update", :controller=>"tags"}
#                                          DELETE /tags/:id(.:format)                                                 {:action=>"destroy", :controller=>"tags"}
#                            show_tag_type        /tags/:id/:type                                                     {:action=>"show", :controller=>"tags"}
#                              search_tags        /search/tags                                                        {:action=>"show", :controller=>"tags"}
#                               categories GET    /categories(.:format)                                               {:action=>"index", :controller=>"categories"}
#                                          POST   /categories(.:format)                                               {:action=>"create", :controller=>"categories"}
#                             new_category GET    /categories/new(.:format)                                           {:action=>"new", :controller=>"categories"}
#                            edit_category GET    /categories/:id/edit(.:format)                                      {:action=>"edit", :controller=>"categories"}
#                                 category GET    /categories/:id(.:format)                                           {:action=>"show", :controller=>"categories"}
#                                          PUT    /categories/:id(.:format)                                           {:action=>"update", :controller=>"categories"}
#                                          DELETE /categories/:id(.:format)                                           {:action=>"destroy", :controller=>"categories"}
#                                   skills GET    /skills(.:format)                                                   {:action=>"index", :controller=>"skills"}
#                                          POST   /skills(.:format)                                                   {:action=>"create", :controller=>"skills"}
#                                new_skill GET    /skills/new(.:format)                                               {:action=>"new", :controller=>"skills"}
#                               edit_skill GET    /skills/:id/edit(.:format)                                          {:action=>"edit", :controller=>"skills"}
#                                    skill GET    /skills/:id(.:format)                                               {:action=>"show", :controller=>"skills"}
#                                          PUT    /skills/:id(.:format)                                               {:action=>"update", :controller=>"skills"}
#                                          DELETE /skills/:id(.:format)                                               {:action=>"destroy", :controller=>"skills"}
#                              event_rsvps POST   /events/:event_id/rsvps(.:format)                                   {:action=>"create", :controller=>"rsvps"}
#                           new_event_rsvp GET    /events/:event_id/rsvps/new(.:format)                               {:action=>"new", :controller=>"rsvps"}
#                          edit_event_rsvp GET    /events/:event_id/rsvps/:id/edit(.:format)                          {:action=>"edit", :controller=>"rsvps"}
#                               event_rsvp PUT    /events/:event_id/rsvps/:id(.:format)                               {:action=>"update", :controller=>"rsvps"}
#                                          DELETE /events/:event_id/rsvps/:id(.:format)                               {:action=>"destroy", :controller=>"rsvps"}
#                              ical_events GET    /events/ical(.:format)                                              {:action=>"ical", :controller=>"events"}
#                              past_events GET    /events/past(.:format)                                              {:action=>"past", :controller=>"events"}
#                                   events GET    /events(.:format)                                                   {:action=>"index", :controller=>"events"}
#                                          POST   /events(.:format)                                                   {:action=>"create", :controller=>"events"}
#                                new_event GET    /events/new(.:format)                                               {:action=>"new", :controller=>"events"}
#                               edit_event GET    /events/:id/edit(.:format)                                          {:action=>"edit", :controller=>"events"}
#                              clone_event GET    /events/:id/clone(.:format)                                         {:action=>"clone", :controller=>"events"}
#                                    event GET    /events/:id(.:format)                                               {:action=>"show", :controller=>"events"}
#                                          PUT    /events/:id(.:format)                                               {:action=>"update", :controller=>"events"}
#                                          DELETE /events/:id(.:format)                                               {:action=>"destroy", :controller=>"events"}
#                                favorites GET    /:favoritable_type/:favoritable_id/favorites(.:format)              {:action=>"index", :controller=>"favorites"}
#                                          POST   /:favoritable_type/:favoritable_id/favorites(.:format)              {:action=>"create", :controller=>"favorites"}
#                             new_favorite GET    /:favoritable_type/:favoritable_id/favorites/new(.:format)          {:action=>"new", :controller=>"favorites"}
#                            edit_favorite GET    /:favoritable_type/:favoritable_id/favorites/:id/edit(.:format)     {:action=>"edit", :controller=>"favorites"}
#                                 favorite GET    /:favoritable_type/:favoritable_id/favorites/:id(.:format)          {:action=>"show", :controller=>"favorites"}
#                                          PUT    /:favoritable_type/:favoritable_id/favorites/:id(.:format)          {:action=>"update", :controller=>"favorites"}
#                                          DELETE /:favoritable_type/:favoritable_id/favorites/:id(.:format)          {:action=>"destroy", :controller=>"favorites"}
#                                 comments GET    /:commentable_type/:commentable_id/comments(.:format)               {:action=>"index", :controller=>"comments"}
#                                          POST   /:commentable_type/:commentable_id/comments(.:format)               {:action=>"create", :controller=>"comments"}
#                              new_comment GET    /:commentable_type/:commentable_id/comments/new(.:format)           {:action=>"new", :controller=>"comments"}
#                             edit_comment GET    /:commentable_type/:commentable_id/comments/:id/edit(.:format)      {:action=>"edit", :controller=>"comments"}
#                                  comment GET    /:commentable_type/:commentable_id/comments/:id(.:format)           {:action=>"show", :controller=>"comments"}
#                                          PUT    /:commentable_type/:commentable_id/comments/:id(.:format)           {:action=>"update", :controller=>"comments"}
#                                          DELETE /:commentable_type/:commentable_id/comments/:id(.:format)           {:action=>"destroy", :controller=>"comments"}
#                 delete_selected_comments        /comments/delete_selected                                           {:action=>"delete_selected", :controller=>"comments"}
#                        homepage_features GET    /homepage_features(.:format)                                        {:action=>"index", :controller=>"homepage_features"}
#                                          POST   /homepage_features(.:format)                                        {:action=>"create", :controller=>"homepage_features"}
#                     new_homepage_feature GET    /homepage_features/new(.:format)                                    {:action=>"new", :controller=>"homepage_features"}
#                    edit_homepage_feature GET    /homepage_features/:id/edit(.:format)                               {:action=>"edit", :controller=>"homepage_features"}
#                         homepage_feature GET    /homepage_features/:id(.:format)                                    {:action=>"show", :controller=>"homepage_features"}
#                                          PUT    /homepage_features/:id(.:format)                                    {:action=>"update", :controller=>"homepage_features"}
#                                          DELETE /homepage_features/:id(.:format)                                    {:action=>"destroy", :controller=>"homepage_features"}
#                              metro_areas GET    /metro_areas(.:format)                                              {:action=>"index", :controller=>"metro_areas"}
#                                          POST   /metro_areas(.:format)                                              {:action=>"create", :controller=>"metro_areas"}
#                           new_metro_area GET    /metro_areas/new(.:format)                                          {:action=>"new", :controller=>"metro_areas"}
#                          edit_metro_area GET    /metro_areas/:id/edit(.:format)                                     {:action=>"edit", :controller=>"metro_areas"}
#                               metro_area GET    /metro_areas/:id(.:format)                                          {:action=>"show", :controller=>"metro_areas"}
#                                          PUT    /metro_areas/:id(.:format)                                          {:action=>"update", :controller=>"metro_areas"}
#                                          DELETE /metro_areas/:id(.:format)                                          {:action=>"destroy", :controller=>"metro_areas"}
#                                          GET    /degrees(.:format)                                                  {:action=>"index", :controller=>"degrees"}
#                                          POST   /degrees(.:format)                                                  {:action=>"create", :controller=>"degrees"}
#                                          GET    /degrees/new(.:format)                                              {:action=>"new", :controller=>"degrees"}
#                                          GET    /degrees/:id/edit(.:format)                                         {:action=>"edit", :controller=>"degrees"}
#                                          GET    /degrees/:id(.:format)                                              {:action=>"show", :controller=>"degrees"}
#                                          PUT    /degrees/:id(.:format)                                              {:action=>"update", :controller=>"degrees"}
#                                          DELETE /degrees/:id(.:format)                                              {:action=>"destroy", :controller=>"degrees"}
#                                countries GET    /countries(.:format)                                                {:action=>"index", :controller=>"countries"}
#                                          POST   /countries(.:format)                                                {:action=>"create", :controller=>"countries"}
#                              new_country GET    /countries/new(.:format)                                            {:action=>"new", :controller=>"countries"}
#                             edit_country GET    /countries/:id/edit(.:format)                                       {:action=>"edit", :controller=>"countries"}
#                                  country GET    /countries/:id(.:format)                                            {:action=>"show", :controller=>"countries"}
#                                          PUT    /countries/:id(.:format)                                            {:action=>"update", :controller=>"countries"}
#                                          DELETE /countries/:id(.:format)                                            {:action=>"destroy", :controller=>"countries"}
#                               list_items GET    /list_items(.:format)                                               {:action=>"index", :controller=>"list_items"}
#                                          POST   /list_items(.:format)                                               {:action=>"create", :controller=>"list_items"}
#                            new_list_item GET    /list_items/new(.:format)                                           {:action=>"new", :controller=>"list_items"}
#                           edit_list_item GET    /list_items/:id/edit(.:format)                                      {:action=>"edit", :controller=>"list_items"}
#                                list_item GET    /list_items/:id(.:format)                                           {:action=>"show", :controller=>"list_items"}
#                                          PUT    /list_items/:id(.:format)                                           {:action=>"update", :controller=>"list_items"}
#                                          DELETE /list_items/:id(.:format)                                           {:action=>"destroy", :controller=>"list_items"}
#                                    lists GET    /lists(.:format)                                                    {:action=>"index", :controller=>"lists"}
#                                          POST   /lists(.:format)                                                    {:action=>"create", :controller=>"lists"}
#                                 new_list GET    /lists/new(.:format)                                                {:action=>"new", :controller=>"lists"}
#                                edit_list GET    /lists/:id/edit(.:format)                                           {:action=>"edit", :controller=>"lists"}
#                                     list GET    /lists/:id(.:format)                                                {:action=>"show", :controller=>"lists"}
#                                          PUT    /lists/:id(.:format)                                                {:action=>"update", :controller=>"lists"}
#                                          DELETE /lists/:id(.:format)                                                {:action=>"destroy", :controller=>"lists"}
#                              experiences GET    /experiences(.:format)                                              {:action=>"index", :controller=>"experiences"}
#                                          POST   /experiences(.:format)                                              {:action=>"create", :controller=>"experiences"}
#                           new_experience GET    /experiences/new(.:format)                                          {:action=>"new", :controller=>"experiences"}
#                          edit_experience GET    /experiences/:id/edit(.:format)                                     {:action=>"edit", :controller=>"experiences"}
#                               experience GET    /experiences/:id(.:format)                                          {:action=>"show", :controller=>"experiences"}
#                                          PUT    /experiences/:id(.:format)                                          {:action=>"update", :controller=>"experiences"}
#                                          DELETE /experiences/:id(.:format)                                          {:action=>"destroy", :controller=>"experiences"}
#                                      ads GET    /ads(.:format)                                                      {:action=>"index", :controller=>"ads"}
#                                          POST   /ads(.:format)                                                      {:action=>"create", :controller=>"ads"}
#                                   new_ad GET    /ads/new(.:format)                                                  {:action=>"new", :controller=>"ads"}
#                                  edit_ad GET    /ads/:id/edit(.:format)                                             {:action=>"edit", :controller=>"ads"}
#                                       ad GET    /ads/:id(.:format)                                                  {:action=>"show", :controller=>"ads"}
#                                          PUT    /ads/:id(.:format)                                                  {:action=>"update", :controller=>"ads"}
#                                          DELETE /ads/:id(.:format)                                                  {:action=>"destroy", :controller=>"ads"}
#                         current_contests GET    /contests/current(.:format)                                         {:action=>"current", :controller=>"contests"}
#                                 contests GET    /contests(.:format)                                                 {:action=>"index", :controller=>"contests"}
#                                          POST   /contests(.:format)                                                 {:action=>"create", :controller=>"contests"}
#                              new_contest GET    /contests/new(.:format)                                             {:action=>"new", :controller=>"contests"}
#                             edit_contest GET    /contests/:id/edit(.:format)                                        {:action=>"edit", :controller=>"contests"}
#                                  contest GET    /contests/:id(.:format)                                             {:action=>"show", :controller=>"contests"}
#                                          PUT    /contests/:id(.:format)                                             {:action=>"update", :controller=>"contests"}
#                                          DELETE /contests/:id(.:format)                                             {:action=>"destroy", :controller=>"contests"}
#                               activities GET    /activities(.:format)                                               {:action=>"index", :controller=>"activities"}
#                                          POST   /activities(.:format)                                               {:action=>"create", :controller=>"activities"}
#                             new_activity GET    /activities/new(.:format)                                           {:action=>"new", :controller=>"activities"}
#                            edit_activity GET    /activities/:id/edit(.:format)                                      {:action=>"edit", :controller=>"activities"}
#                                 activity GET    /activities/:id(.:format)                                           {:action=>"show", :controller=>"activities"}
#                                          PUT    /activities/:id(.:format)                                           {:action=>"update", :controller=>"activities"}
#                                          DELETE /activities/:id(.:format)                                           {:action=>"destroy", :controller=>"activities"}
#                accepted_user_friendships GET    /:user_id/friendships/accepted(.:format)                            {:action=>"accepted", :controller=>"friendships"}
#                 pending_user_friendships GET    /:user_id/friendships/pending(.:format)                             {:action=>"pending", :controller=>"friendships"}
#                  denied_user_friendships GET    /:user_id/friendships/denied(.:format)                              {:action=>"denied", :controller=>"friendships"}
#                         user_friendships GET    /:user_id/friendships(.:format)                                     {:action=>"index", :controller=>"friendships"}
#                                          POST   /:user_id/friendships(.:format)                                     {:action=>"create", :controller=>"friendships"}
#                      new_user_friendship GET    /:user_id/friendships/new(.:format)                                 {:action=>"new", :controller=>"friendships"}
#                     edit_user_friendship GET    /:user_id/friendships/:id/edit(.:format)                            {:action=>"edit", :controller=>"friendships"}
#                     deny_user_friendship PUT    /:user_id/friendships/:id/deny(.:format)                            {:action=>"deny", :controller=>"friendships"}
#                   accept_user_friendship PUT    /:user_id/friendships/:id/accept(.:format)                          {:action=>"accept", :controller=>"friendships"}
#                          user_friendship GET    /:user_id/friendships/:id(.:format)                                 {:action=>"show", :controller=>"friendships"}
#                                          PUT    /:user_id/friendships/:id(.:format)                                 {:action=>"update", :controller=>"friendships"}
#                                          DELETE /:user_id/friendships/:id(.:format)                                 {:action=>"destroy", :controller=>"friendships"}
#                    slideshow_user_photos GET    /:user_id/photos/slideshow(.:format)                                {:action=>"slideshow", :controller=>"photos"}
#                    swfupload_user_photos POST   /:user_id/photos/swfupload(.:format)                                {:action=>"swfupload", :controller=>"photos"}
#                              user_photos GET    /:user_id/photos(.:format)                                          {:action=>"index", :controller=>"photos"}
#                                          POST   /:user_id/photos(.:format)                                          {:action=>"create", :controller=>"photos"}
#                           new_user_photo GET    /:user_id/photos/new(.:format)                                      {:action=>"new", :controller=>"photos"}
#                          edit_user_photo GET    /:user_id/photos/:id/edit(.:format)                                 {:action=>"edit", :controller=>"photos"}
#                               user_photo GET    /:user_id/photos/:id(.:format)                                      {:action=>"show", :controller=>"photos"}
#                                          PUT    /:user_id/photos/:id(.:format)                                      {:action=>"update", :controller=>"photos"}
#                                          DELETE /:user_id/photos/:id(.:format)                                      {:action=>"destroy", :controller=>"photos"}
#                        manage_user_posts GET    /:user_id/posts/manage(.:format)                                    {:action=>"manage", :controller=>"posts"}
#                               user_posts GET    /:user_id/posts(.:format)                                           {:action=>"index", :controller=>"posts"}
#                                          POST   /:user_id/posts(.:format)                                           {:action=>"create", :controller=>"posts"}
#                            new_user_post GET    /:user_id/posts/new(.:format)                                       {:action=>"new", :controller=>"posts"}
#                           edit_user_post GET    /:user_id/posts/:id/edit(.:format)                                  {:action=>"edit", :controller=>"posts"}
#                        contest_user_post GET    /:user_id/posts/:id/contest(.:format)                               {:action=>"contest", :controller=>"posts"}
#                 send_to_friend_user_post        /:user_id/posts/:id/send_to_friend(.:format)                        {:action=>"send_to_friend", :controller=>"posts"}
#                   update_views_user_post        /:user_id/posts/:id/update_views(.:format)                          {:action=>"update_views", :controller=>"posts"}
#                                user_post GET    /:user_id/posts/:id(.:format)                                       {:action=>"show", :controller=>"posts"}
#                                          PUT    /:user_id/posts/:id(.:format)                                       {:action=>"update", :controller=>"posts"}
#                                          DELETE /:user_id/posts/:id(.:format)                                       {:action=>"destroy", :controller=>"posts"}
#                              user_events GET    /:user_id/events(.:format)                                          {:action=>"index", :controller=>"events"}
#                                          POST   /:user_id/events(.:format)                                          {:action=>"create", :controller=>"events"}
#                           new_user_event GET    /:user_id/events/new(.:format)                                      {:action=>"new", :controller=>"events"}
#                          edit_user_event GET    /:user_id/events/:id/edit(.:format)                                 {:action=>"edit", :controller=>"events"}
#                               user_event GET    /:user_id/events/:id(.:format)                                      {:action=>"show", :controller=>"events"}
#                                          PUT    /:user_id/events/:id(.:format)                                      {:action=>"update", :controller=>"events"}
#                                          DELETE /:user_id/events/:id(.:format)                                      {:action=>"destroy", :controller=>"events"}
#                           user_clippings GET    /:user_id/clippings(.:format)                                       {:action=>"index", :controller=>"clippings"}
#                                          POST   /:user_id/clippings(.:format)                                       {:action=>"create", :controller=>"clippings"}
#                        new_user_clipping GET    /:user_id/clippings/new(.:format)                                   {:action=>"new", :controller=>"clippings"}
#                       edit_user_clipping GET    /:user_id/clippings/:id/edit(.:format)                              {:action=>"edit", :controller=>"clippings"}
#                            user_clipping GET    /:user_id/clippings/:id(.:format)                                   {:action=>"show", :controller=>"clippings"}
#                                          PUT    /:user_id/clippings/:id(.:format)                                   {:action=>"update", :controller=>"clippings"}
#                                          DELETE /:user_id/clippings/:id(.:format)                                   {:action=>"destroy", :controller=>"clippings"}
#                  network_user_activities GET    /:user_id/activities/network(.:format)                              {:action=>"network", :controller=>"activities"}
#                          user_activities GET    /:user_id/activities(.:format)                                      {:action=>"index", :controller=>"activities"}
#                                          POST   /:user_id/activities(.:format)                                      {:action=>"create", :controller=>"activities"}
#                        new_user_activity GET    /:user_id/activities/new(.:format)                                  {:action=>"new", :controller=>"activities"}
#                       edit_user_activity GET    /:user_id/activities/:id/edit(.:format)                             {:action=>"edit", :controller=>"activities"}
#                            user_activity GET    /:user_id/activities/:id(.:format)                                  {:action=>"show", :controller=>"activities"}
#                                          PUT    /:user_id/activities/:id(.:format)                                  {:action=>"update", :controller=>"activities"}
#                                          DELETE /:user_id/activities/:id(.:format)                                  {:action=>"destroy", :controller=>"activities"}
#                         user_invitations GET    /:user_id/invitations(.:format)                                     {:action=>"index", :controller=>"invitations"}
#                                          POST   /:user_id/invitations(.:format)                                     {:action=>"create", :controller=>"invitations"}
#                      new_user_invitation GET    /:user_id/invitations/new(.:format)                                 {:action=>"new", :controller=>"invitations"}
#                     edit_user_invitation GET    /:user_id/invitations/:id/edit(.:format)                            {:action=>"edit", :controller=>"invitations"}
#                          user_invitation GET    /:user_id/invitations/:id(.:format)                                 {:action=>"show", :controller=>"invitations"}
#                                          PUT    /:user_id/invitations/:id(.:format)                                 {:action=>"update", :controller=>"invitations"}
#                                          DELETE /:user_id/invitations/:id(.:format)                                 {:action=>"destroy", :controller=>"invitations"}
#                   replace_user_offerings PUT    /:user_id/offerings/replace(.:format)                               {:action=>"replace", :controller=>"offerings"}
#                           user_offerings GET    /:user_id/offerings(.:format)                                       {:action=>"index", :controller=>"offerings"}
#                                          POST   /:user_id/offerings(.:format)                                       {:action=>"create", :controller=>"offerings"}
#                        new_user_offering GET    /:user_id/offerings/new(.:format)                                   {:action=>"new", :controller=>"offerings"}
#                       edit_user_offering GET    /:user_id/offerings/:id/edit(.:format)                              {:action=>"edit", :controller=>"offerings"}
#                            user_offering GET    /:user_id/offerings/:id(.:format)                                   {:action=>"show", :controller=>"offerings"}
#                                          PUT    /:user_id/offerings/:id(.:format)                                   {:action=>"update", :controller=>"offerings"}
#                                          DELETE /:user_id/offerings/:id(.:format)                                   {:action=>"destroy", :controller=>"offerings"}
#                           user_favorites GET    /:user_id/favorites(.:format)                                       {:action=>"index", :controller=>"favorites"}
#                                          POST   /:user_id/favorites(.:format)                                       {:action=>"create", :controller=>"favorites"}
#                        new_user_favorite GET    /:user_id/favorites/new(.:format)                                   {:action=>"new", :controller=>"favorites"}
#                       edit_user_favorite GET    /:user_id/favorites/:id/edit(.:format)                              {:action=>"edit", :controller=>"favorites"}
#                            user_favorite GET    /:user_id/favorites/:id(.:format)                                   {:action=>"show", :controller=>"favorites"}
#                                          PUT    /:user_id/favorites/:id(.:format)                                   {:action=>"update", :controller=>"favorites"}
#                                          DELETE /:user_id/favorites/:id(.:format)                                   {:action=>"destroy", :controller=>"favorites"}
#            delete_selected_user_messages POST   /:user_id/messages/delete_selected(.:format)                        {:action=>"delete_selected", :controller=>"messages"}
# auto_complete_for_username_user_messages        /:user_id/messages/auto_complete_for_username(.:format)             {:action=>"auto_complete_for_username", :controller=>"messages"}
#                            user_messages GET    /:user_id/messages(.:format)                                        {:action=>"index", :controller=>"messages"}
#                                          POST   /:user_id/messages(.:format)                                        {:action=>"create", :controller=>"messages"}
#                         new_user_message GET    /:user_id/messages/new(.:format)                                    {:action=>"new", :controller=>"messages"}
#                        edit_user_message GET    /:user_id/messages/:id/edit(.:format)                               {:action=>"edit", :controller=>"messages"}
#                             user_message GET    /:user_id/messages/:id(.:format)                                    {:action=>"show", :controller=>"messages"}
#                                          PUT    /:user_id/messages/:id(.:format)                                    {:action=>"update", :controller=>"messages"}
#                                          DELETE /:user_id/messages/:id(.:format)                                    {:action=>"destroy", :controller=>"messages"}
#                            user_comments GET    /:user_id/comments(.:format)                                        {:action=>"index", :controller=>"comments"}
#                                          POST   /:user_id/comments(.:format)                                        {:action=>"create", :controller=>"comments"}
#                         new_user_comment GET    /:user_id/comments/new(.:format)                                    {:action=>"new", :controller=>"comments"}
#                        edit_user_comment GET    /:user_id/comments/:id/edit(.:format)                               {:action=>"edit", :controller=>"comments"}
#                             user_comment GET    /:user_id/comments/:id(.:format)                                    {:action=>"show", :controller=>"comments"}
#                                          PUT    /:user_id/comments/:id(.:format)                                    {:action=>"update", :controller=>"comments"}
#                                          DELETE /:user_id/comments/:id(.:format)                                    {:action=>"destroy", :controller=>"comments"}
#                 user_photo_manager_index GET    /:user_id/photo_manager(.:format)                                   {:action=>"index", :controller=>"photo_manager"}
#              slideshow_user_album_photos GET    /:user_id/photo_manager/albums/:album_id/photos/slideshow(.:format) {:action=>"slideshow", :controller=>"photos"}
#              swfupload_user_album_photos POST   /:user_id/photo_manager/albums/:album_id/photos/swfupload(.:format) {:action=>"swfupload", :controller=>"photos"}
#                        user_album_photos GET    /:user_id/photo_manager/albums/:album_id/photos(.:format)           {:action=>"index", :controller=>"photos"}
#                                          POST   /:user_id/photo_manager/albums/:album_id/photos(.:format)           {:action=>"create", :controller=>"photos"}
#                     new_user_album_photo GET    /:user_id/photo_manager/albums/:album_id/photos/new(.:format)       {:action=>"new", :controller=>"photos"}
#                    edit_user_album_photo GET    /:user_id/photo_manager/albums/:album_id/photos/:id/edit(.:format)  {:action=>"edit", :controller=>"photos"}
#                         user_album_photo GET    /:user_id/photo_manager/albums/:album_id/photos/:id(.:format)       {:action=>"show", :controller=>"photos"}
#                                          PUT    /:user_id/photo_manager/albums/:album_id/photos/:id(.:format)       {:action=>"update", :controller=>"photos"}
#                                          DELETE /:user_id/photo_manager/albums/:album_id/photos/:id(.:format)       {:action=>"destroy", :controller=>"photos"}
#              paginate_photos_user_albums GET    /:user_id/photo_manager/albums/paginate_photos(.:format)            {:action=>"paginate_photos", :controller=>"albums"}
#                              user_albums GET    /:user_id/photo_manager/albums(.:format)                            {:action=>"index", :controller=>"albums"}
#                                          POST   /:user_id/photo_manager/albums(.:format)                            {:action=>"create", :controller=>"albums"}
#                           new_user_album GET    /:user_id/photo_manager/albums/new(.:format)                        {:action=>"new", :controller=>"albums"}
#                  photos_added_user_album POST   /:user_id/photo_manager/albums/:id/photos_added(.:format)           {:action=>"photos_added", :controller=>"albums"}
#                          edit_user_album GET    /:user_id/photo_manager/albums/:id/edit(.:format)                   {:action=>"edit", :controller=>"albums"}
#                    add_photos_user_album GET    /:user_id/photo_manager/albums/:id/add_photos(.:format)             {:action=>"add_photos", :controller=>"albums"}
#                               user_album GET    /:user_id/photo_manager/albums/:id(.:format)                        {:action=>"show", :controller=>"albums"}
#                                          PUT    /:user_id/photo_manager/albums/:id(.:format)                        {:action=>"update", :controller=>"albums"}
#                                          DELETE /:user_id/photo_manager/albums/:id(.:format)                        {:action=>"destroy", :controller=>"albums"}
#                                          GET    /users(.:format)                                                    {:action=>"index", :controller=>"users"}
#                                          POST   /users(.:format)                                                    {:action=>"create", :controller=>"users"}
#                                          GET    /users/new(.:format)                                                {:action=>"new", :controller=>"users"}
#                     forgot_password_user GET    /:id/forgot_password(.:format)                                      {:action=>"forgot_password", :controller=>"users"}
#                                          POST   /:id/forgot_password(.:format)                                      {:action=>"forgot_password", :controller=>"users"}
#                                rate_user POST   /:id/rate(.:format)                                                 {:action=>"rate", :controller=>"users"}
#                                          GET    /:id/edit(.:format)                                                 {:action=>"edit", :controller=>"users"}
#                    signup_completed_user GET    /:id/signup_completed(.:format)                                     {:action=>"signup_completed", :controller=>"users"}
#                        return_admin_user GET    /:id/return_admin(.:format)                                         {:action=>"return_admin", :controller=>"users"}
#                       welcome_photo_user GET    /:id/welcome_photo(.:format)                                        {:action=>"welcome_photo", :controller=>"users"}
#                           dashboard_user GET    /:id/dashboard(.:format)                                            {:action=>"dashboard", :controller=>"users"}
#                        edit_account_user GET    /:id/edit_account(.:format)                                         {:action=>"edit_account", :controller=>"users"}
#                       welcome_about_user GET    /:id/welcome_about(.:format)                                        {:action=>"welcome_about", :controller=>"users"}
#                              invite_user GET    /:id/invite(.:format)                                               {:action=>"invite", :controller=>"users"}
#                              assume_user GET    /:id/assume(.:format)                                               {:action=>"assume", :controller=>"users"}
#                  welcome_stylesheet_user GET    /:id/welcome_stylesheet(.:format)                                   {:action=>"welcome_stylesheet", :controller=>"users"}
#                    edit_pro_details_user GET    /:id/edit_pro_details(.:format)                                     {:action=>"edit_pro_details", :controller=>"users"}
#                      welcome_invite_user GET    /:id/welcome_invite(.:format)                                       {:action=>"welcome_invite", :controller=>"users"}
#                    welcome_complete_user GET    /:id/welcome_complete(.:format)                                     {:action=>"welcome_complete", :controller=>"users"}
#                          statistics_user        /:id/statistics(.:format)                                           {:action=>"statistics", :controller=>"users"}
#                  crop_profile_photo_user GET    /:id/crop_profile_photo(.:format)                                   {:action=>"crop_profile_photo", :controller=>"users"}
#                                          PUT    /:id/crop_profile_photo(.:format)                                   {:action=>"crop_profile_photo", :controller=>"users"}
#                upload_profile_photo_user GET    /:id/upload_profile_photo(.:format)                                 {:action=>"upload_profile_photo", :controller=>"users"}
#                                          PUT    /:id/upload_profile_photo(.:format)                                 {:action=>"upload_profile_photo", :controller=>"users"}
#                          deactivate_user PUT    /:id/deactivate(.:format)                                           {:action=>"deactivate", :controller=>"users"}
#                      update_account_user PUT    /:id/update_account(.:format)                                       {:action=>"update_account", :controller=>"users"}
#                    toggle_moderator_user PUT    /:id/toggle_moderator(.:format)                                     {:action=>"toggle_moderator", :controller=>"users"}
#                     toggle_featured_user PUT    /:id/toggle_featured(.:format)                                      {:action=>"toggle_featured", :controller=>"users"}
#                  update_pro_details_user PUT    /:id/update_pro_details(.:format)                                   {:action=>"update_pro_details", :controller=>"users"}
#                change_profile_photo_user PUT    /:id/change_profile_photo(.:format)                                 {:action=>"change_profile_photo", :controller=>"users"}
#                                          GET    /:id(.:format)                                                      {:action=>"show", :controller=>"users"}
#                                          PUT    /:id(.:format)                                                      {:action=>"update", :controller=>"users"}
#                                          DELETE /:id(.:format)                                                      {:action=>"destroy", :controller=>"users"}
#                                    votes GET    /votes(.:format)                                                    {:action=>"index", :controller=>"votes"}
#                                          POST   /votes(.:format)                                                    {:action=>"create", :controller=>"votes"}
#                                 new_vote GET    /votes/new(.:format)                                                {:action=>"new", :controller=>"votes"}
#                                edit_vote GET    /votes/:id/edit(.:format)                                           {:action=>"edit", :controller=>"votes"}
#                                     vote GET    /votes/:id(.:format)                                                {:action=>"show", :controller=>"votes"}
#                                          PUT    /votes/:id(.:format)                                                {:action=>"update", :controller=>"votes"}
#                                          DELETE /votes/:id(.:format)                                                {:action=>"destroy", :controller=>"votes"}
#                              invitations GET    /invitations(.:format)                                              {:action=>"index", :controller=>"invitations"}
#                                          POST   /invitations(.:format)                                              {:action=>"create", :controller=>"invitations"}
#                           new_invitation GET    /invitations/new(.:format)                                          {:action=>"new", :controller=>"invitations"}
#                          edit_invitation GET    /invitations/:id/edit(.:format)                                     {:action=>"edit", :controller=>"invitations"}
#                               invitation GET    /invitations/:id(.:format)                                          {:action=>"show", :controller=>"invitations"}
#                                          PUT    /invitations/:id(.:format)                                          {:action=>"update", :controller=>"invitations"}
#                                          DELETE /invitations/:id(.:format)                                          {:action=>"destroy", :controller=>"invitations"}
#                  users_posts_in_category        /users/:user_id/posts/category/:category_name                       {:action=>"index", :controller=>"posts"}
#                                          GET    /stylesheets/theme/:filename                                        {:action=>"stylesheets", :controller=>"theme"}
#                                          GET    /javascripts/theme/:filename                                        {:action=>"javascript", :controller=>"theme"}
#                                          GET    /images/theme/:filename                                             {:action=>"images", :controller=>"theme"}
#                   deprecated_popular_rss        /popular_rss                                                        {:action=>"popular", :format=>"rss", :controller=>"base"}
#                  deprecated_category_rss        /categories/:id;rss                                                 {:action=>"show", :format=>"rss", :controller=>"categories"}
#                     deprecated_posts_rss        /:user_id/posts;rss                                                 {:action=>"index", :format=>"rss", :controller=>"posts"}
#                                                 /:controller/:action/:id                                            
#                                                 /:controller/:action/:id(.:format)                                  
