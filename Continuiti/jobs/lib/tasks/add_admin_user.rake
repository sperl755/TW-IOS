namespace :users do
  desc 'Creating admin user...'
  task :add_admin_user => :environment do
      u = User.new
      u.login = "admin"
      u.name = "admin"
      u.first_name = "admin"
      u.password = "administrator"
      u.password_confirmation = "administrator"
      u.email = "admin@hydrogen.xen.exoware.net"
      u.birthday = Date.new(1980,1,1)
      u.role_id = 1
      u.save
      u.activate
      u.save
  end
end