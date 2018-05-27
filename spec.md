# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database :: AR is used to communicate with database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) :: Has User, Dive and Divesite models
- [x] Include at least one has_many relationship on your User model (x has_many y, e.g. User has_many Posts) :: User has_many Dives
- [x] Include at least one belongs_to relationship on another model (x belongs_to y, e.g. Post belongs_to User) :: Dive belongs_to Divesite
- [x] Include user accounts :: Users can create, update and log in and out of their account
- [x] Ensure that users can't modify content created by other users :: Session validation prevents eg. User to edit/delete another User's Dive
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying :: Dive can be C,R,U and D!
- [x] Include user input validations :: Implementation of HTML5, AR and custom validations
- [X] Display validation failures to user with error message (example form URL e.g. /posts/new) :: HTML and Sinatra::Flash alerts implemented
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits :: Across 4 branches I have 32 commits and counting
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
