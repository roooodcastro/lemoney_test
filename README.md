# Test challenge for Lemoney

## Instructions to execute the presented application:

### Heroku

This app is also hosted on Heroku, and to access it, go to:

    lemoney-test.herokuapp.com

### Local

To execute the app locally, just follow these regular steps to execute a Rails app:

If you're not using RVM, check if you're using Ruby 2.4.x

    $ bundle install
    $ rails db:create
    $ rails db:schema:load
    $ rails db:seed
    $ rails s
    
The seeds file will create an admin user, as well as 50 randomly
generated offers, with 15 being offers without an end date, and 35 being offers
with end dates.

### To execute the automated tests, just run the rspec command:

    $ rspec

### To login to the admin area of the app, login as the admin user created by the seeds:

    email: admin@example.com
    senha: 123456
