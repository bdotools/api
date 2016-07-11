source 'https://rubygems.org'
ruby '2.3.1'

gem 'active_model_serializers'
gem 'csv-importer'
gem 'dotenv-rails'
gem 'newrelic_rpm'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'seven_zip_ruby'
gem 'sidekiq'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'rack-cors'
gem 'workflow'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.4'
end

group :development do
  gem 'capistrano', '~> 3.4'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
