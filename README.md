# README

rails API allowing REST requests that return basic volleyball statistics data.

* Ruby version - 3.3.26

* System dependencies:

    # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
    gem "rails", "~> 7.0.4"

    # Use sqlite3 as the database for Active Record
    gem "mysql2"

    # Use the Puma web server [https://github.com/puma/puma]
    gem "puma", "~> 5.0"

    # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
    gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

    # Reduces boot times through caching; required in config/boot.rb
    gem "bootsnap", require: false

    gem "faker"

    gem "debug", platforms: %i[ mri mingw x64_mingw ]

    gem 'rubocop'

* Database creation
Database has to be named 'Volleyball_statistics' and have set password '1234'

* Database initialization
run these commands to get your database schema loaded and insert basic random data into it.
rails db:schema:load
rails db:seed

