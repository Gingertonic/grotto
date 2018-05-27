# Grotto

## Hello! Welcome to Grotto. This is a web application for logging SCUBA dives and networking with fellow divers.

At a minimum, users can:
  + Create an account, login and logout
  + Log a dive
  + See a news feed of dives logged by other divers
  + See and contribute to a dedicated page for each dive spot logged

Future functionality may include:
  + Follow fellow divers who use the app and assign them as their dive buddy for a dive
  + See a tailored news feed of new dives made by divers they have followed
  + Search for other divers who are using the app
  + Pressure tables algorithms to work out safe dive plans.

## Installation instructions

To run this app on a local server:
  1. In a bash terminal of your choice run:
    + `git clone git@github.com:Gingertonic/grotto.git` to use SSH or
    + `git clone https://github.com/Gingertonic/grotto.git` to use HTTPS
  2. Run `cd grotto` then `bundle install`
  4. Run `rake db:seed` if you'd like to see this working with some pre-made Divers!
  5. Run `shotgun` and open the link provided in your browser. (Usually `http://localhost:9393/`)
  6. Play!


## This is created for a Flatiron School Portfolio Project

Skills shown include:
  + MVC application models
  + ActiveRecord and SQL
  + Sinatra framework
  + Object orientation
  + Ruby
  + HTML, ERB & CSS
  + RESTful routing
  + TDD

The requirements for this project are:
  1. Build an MVC Sinatra application.
  2. Use ActiveRecord with Sinatra.
  3. Use Multiple Models.
  4. Use at least one `has_many` relationship on a User model and one `belongs_to` relationship on another model.
  5. Must have user accounts. The user that created a given piece of information should be the only person who can modify that content.
  6. Must have the ability to create, read, update and destroy any instance of the resource that belongs to a user.
  7. Ensure that any instance of the resource that belongs to a user can be edited or deleted only by that user.
  8. You should also have validations for user input to ensure that bad data is not added to the database. The fields in your signup form should be required and the user attribute that is used to login a user should be a unique value in the DB before creating the user.

## Contributions

If you would like to suggest an improvement or new feature that would be awesome!
To do this:
  1. fork and clone this repo
  2. `cd` into the project folder and run `bundle install`
  3. run `rspec` to make sure the tests are passing for you
  4. make a new branch for your changes - try and use a relevant name `git checkout -b <your-branch-name>`
      + eg. `git checkout -b awesome-new-feature`
  5. make your changes and/or additions
  6. push your changes to your own fork
  7. submit a pull request

After submitting your pull request, I will review it as soon as I can.
It would super extra awesome if you can
  + Include tests for you new features
  + Make a relevant commit message and add a solid description with the request.
