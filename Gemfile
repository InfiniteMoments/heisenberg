source 'https://rubygems.org'

ruby "2.1.2"

gem 'rails', '4.2.0'

gem 'rails-api'

gem 'pg', '0.18.1'


# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
gem 'jbuilder'

gem 'jwt'

# Timeout and log requests that run too long
gem 'rack-timeout'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'spring'
end

group :test do
  gem 'minitest-reporters', '1.0.10'
  gem 'mini_backtrace', '0.1.3'
  gem 'guard-minitest', '2.4.3'
end

group :production do
  gem 'rails_12factor', '0.0.3'
  gem 'puma'
end
