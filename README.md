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
  2. Run `cd grotto`
  3. Run `shotgun` and navigate to the address provided (Usually `127.0.0.1:9393`)
    + if a port number is given instead go to `http://localhost:<port>/` (Usually `http://localhost:9393`)
  4. Play!
    + You can make you own account or you can use these credentials to log in as a pre-made user:
      + username: `gingertonic` / password: `password`
      
   - If you encounter any problems or cannot access the gingertonic test account, run these steps after step 2 above)
    3. run `bundle install`
    4. Run `rake db:seed`
    5. Back to step 3 as above (run `shotgun`)


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
  
## License
 
The MIT License (MIT)

Copyright (c) 2015 Chris Kibble

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
