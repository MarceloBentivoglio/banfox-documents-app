source 'https://rubygems.org'
ruby '2.5.3'

gem 'bootsnap', require: false
gem 'devise'
gem 'jbuilder', '~> 2.0'
gem 'pg', '~> 0.21'
gem 'puma'
gem 'rails', '5.2.2'
gem 'redis'

gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'sassc-rails'
gem 'simple_form'
gem 'uglifier'
gem 'webpacker'

# Used to create authorizations
gem 'pundit'

# Used to create the pdf from html
gem "pdfkit"

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails'
end

group :production do
# Used to create the pdf from html on production
  gem "wkhtmltopdf-heroku"
end
