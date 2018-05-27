# NOTES

## USER STORY
+ Aleksandar is a regular diver
+  He can visit Grotto and see an index page where he can follow a link to sign up
+  He can make a new account on Grotto and see all the dives logged by other users
+  He can see a page dedicated to another user's dive. He cannot edit it or delete it
+  He can see another user's divelog
+  He can look at a list of all the divesites that have been added to Grotto.
+  He can see a page dedicated to a particular divesite and see a list of all the Grotto users who have logged a dive at that site as well as local dive centres.
+  He can edit the divesite but only if it still has a name, location and country AND the updated divesite details do not create a duplicate of another divesite.
+  He can delete a divesite but only if no other users have logged a dive there.
+  He can see his own divelog - at the moment it is empty!
+  He can log a new dive as long as it has a valid date (format DD/MM/YYYY) and the date is valid
+  He can see his new dive on his divelog
+  He can see his new dive on the dives index with all the other users' dives
+  He can see a page dedicated to any of his dives
+  He can edit any of his dives as long as they still have a valid date
+  He can delete any of his dives
+  He can create a new divesite at the same time as he logs a new dive as long as the divesite and dive are both valid
+  He can log a new dive at the same time as he creates a new divesite as long as the divesite and dive are both valid

+  He can edit his user account details as long his password is validated and he has a first name, last name, username and email.
+  He can change his password as long as he validates with his old password
+  He can logout and be redirected to a login page

+  He can visit the website again later and from the welcome page he can follow a link to login
+  He can login from the login page and all his dives are still available
+  He can navigate away from the Grotto website without logging out and when he returns, he does not have to sign in


## TO ADD IN FUTURE
+ Ability to add and track dive qualifications
+ Ability to 'follow' other divers and see a customised dive feed of only their dives
+ Ability to search for other users
+ Ability to add a dive buddy (another user) to each dive and have the dive connected to both users

## CURRENT LIMITATIONS
+ Each user can only see a page for their first logged dive for a given divesite on a given day that day [They can log multiple dives a single site on a single day but only view the first]


## SOME ISSUES THAT AROSE (just a small sample!)
+ Incorrect singularization of Dives (Dife!) by AR
- Fixed by adding activesupport gem and making an inflection file in config folder, required in config.ru
- (Problem arose again later when using with Tux, fixed by using `has_many :dives, :class_name => "Dive"` in User and Divesite models)

+ Tux not loading
- Fixed by using require not require_relative in config.ru

+ `has_many, through` associations not working
- Fixed by simplifying - join table was not required


## TIMELINE

### MONDAY
- Plan out app and file structure

### TUESDAY GOALS:
- Create base app structure
- Write initial tests
- Get all model tests passing
- Attend lecture on Capybara testing

### WEDNESDAY
- Finish writing tests
- Record 30min coding session
- Update tests if needed (add Capybara)
- Continue working on controller tests
- Get all basic views written

### THURSDAY
- Pass all updated tests
- Finish all basic views
- Have fully functioning basic app
- Attend Sinatra Office Hours

### FRIDAY
- Complete all technical requirements for project
- Start HTML/CSS

### SATURDAY
- Complete HTML/CSS

### SUNDAY
- Retest and adjust as needed to accommodate any copy changes made during front end design
- Tidy HTML/erb
- Improve seeds
- Make any other improvements noticed during testing full seeds
- Update Readme, spec and notes
- Push complete final project


+ Record Walkthrough
+ Write blogpost
+ Submit for Assessment!
