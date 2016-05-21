source 'https://rubygems.org'
ruby '2.3.1'

gem 'active_model_serializers'
gem 'dotenv-rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'rack-cors'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

group :development, :test do
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end

  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
end

group :development do
  gem 'capistrano', '~> 3.4'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
