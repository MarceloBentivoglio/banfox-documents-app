source 'https://rubygems.org'
ruby '2.6.3'

gem 'bootsnap', require: false
gem 'devise'
gem 'jbuilder', '~> 2.0'
gem 'pg', '~> 0.21'
gem 'puma'
gem 'rails', '5.2.2'
gem 'redis'

gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.8.1'
gem 'sassc-rails'
gem 'simple_form'
gem 'uglifier'
gem 'webpacker'

# Used to create authorizations
gem 'pundit'

# Used to create the pdf from html
gem "pdfkit"

# Used to create tokens for our API
gem 'simple_token_authentication'

# Used to create simple http requests
gem 'rest-client'

# Used to track erros in production
gem 'rollbar'

# Used to create pdf from html
gem 'grover', git: 'https://github.com/sasakibanfox/grover.git'

# Used to keep the documents generated on Amazon S3
gem "aws-sdk-s3", require: false

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
  gem "wkhtmltopdf-heroku", git: "https://github.com/gregnavis/wkhtmltopdf-heroku"
end
