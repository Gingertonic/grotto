# Grotto

## Hello! Welcome to Grotto. This is a web application for logging SCUBA dives and networking with fellow divers.

At a minimum, users will be able to:
  + Create an account, login and logout
  + Log a dive made in the past or the same day
  + See a news feed of dives logged by other divers
  + See and contribute to a dedicated page for each dive spot logged

Future functionality may include:
  + Follow fellow divers who use the app and assign them as their dive buddy for a dive
  + See a tailored news feed of new dives made by divers they have followed
  + Search for other divers who are using the app
  + Pressure tables algorithms to work out safe dive plans.


## This is created for a Flatiron School Portfolio Project.

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
