#ENV['SINATRA_ENV'] ||= "development" ## THIS LINE MEANS?

require 'bundler'#/setup'
Bundler.require#(:default, ENV['SINATRA_ENV']) ## END THIS LINE MEANS?

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"#{ENV['SINATRA_ENV']}.sqlite" ## ENV['SINTRA_ENV' MEANS?]
)

require_all 'app'
