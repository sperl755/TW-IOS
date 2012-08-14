APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/app_constants.yml")[RAILS_ENV]
FACEBOOKER_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/facebooker.yml")[RAILS_ENV]