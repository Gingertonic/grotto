require 'database_cleaner'

User.destroy_all
Dive.destroy_all
Divesite.destroy_all

DatabaseCleaner.clean_with(:truncation)

beth = User.create({first_name: "Beth", last_name: "Schofield", username: "gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})
al = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "marinescience"})
chris = User.create({first_name: "Chris", last_name: "Zoumadakis", username: "chreece_from_greece", email: "chris@greece.com", password: "iamchreecefromgreece"})
sarah = User.create({first_name: "Sarah", last_name: "Jaban", username: "mermaid_princess", email: "sarah@mermaids.com", password: "mermaidpower"})
mum = User.create({first_name: "Christine", last_name: "Schofield", username: "chyanros", email: "mummy@gingertonic.com", password: "mummy"})
gemma = User.create({first_name: "Gemma", last_name: "Fuller", username: "trumpet-gems", email: "gemma@circus.com", password: "trumpetsrule"})
avi = User.create({first_name: "Avi", last_name: "Flombaum", username: "code-master-avi", email: "avi@flatironschool.com", password: "flatironrules"})
tyrone = User.create({first_name: "Tyrone", last_name: "Brown", username: "irish_lad", email: "tyrone@ireland.com", password: "divingisthebest"})


chrisdive1 = chris.dives.create({date: "13/07/2016", time: "09:00", length: 33, notes: "Group of new divers. Awful."}) #nana beach pool
sarahdive2 = sarah.dives.create({date: "13/07/2016", time: "09:00", length: 33, notes: "The amazing wall. I wish I was a mermaid..."}) #nana beach wall
tyronedive1 = tyrone.dives.create({date: "13/07/2016", time: "09:00", length: 33, notes: "Assisted with Discover group. I love my job!"}) #nana beach pool
tyronedive2 = tyrone.dives.create({date: "13/07/2016", time: "14:00", length: 54, notes: "Boat dive! Bloody brilliant"}) #nana beach place wreck
chrisdive3 = chris.dives.create({date: "13/07/2016", time: "14:00", length: 54, notes: "Great to get on the boat. At last."}) #nana beach place wreck

bethdive1 = beth.dives.create({date: "14/07/2016", time: "10:00", length: 46, notes: "First open water dive!"}) #nana beach sandy flats
chrisdive2 = chris.dives.create({date: "14/07/2016", time: "10:00", length: 46, notes: "Took hapless new diver on her first open water."}) #nana beach sandy flats
sarahdive1 = sarah.dives.create({date: "14/07/2016", time: "10:00", length: 46, notes: "Super first open water dive for a new group."}) #nana beach sandy flats

bethdive2 = beth.dives.create({date: "24/07/2016", time: "09:00", length: 53, notes: "Awesome plane wreck. No plants big saw a pair of huge grouper"}) #nana beach plane wreck
chrisdive4 = chris.dives.create({date: "24/07/2016", time: "09:00", length: 53, notes: "Took student to plane wreck. She handled it great, she is a fantastic diver, The best I've ever taught."}) #nana beach place wreck
sarahdive3 = sarah.dives.create({date: "24/07/2016", time: "09:00", length: 53, notes: "You know... I should open a mermaid school"}) #nana beach place wreck
tyronedive3 = tyrone.dives.create({date: "24/07/2016", time: "09:00", length: 53, notes: "Awesome wreck dive, and Beth's first deep dive, it went so well."}) #nana beach place wreck

aldive1 = al.dives.create({date: "30/01/2017", time: "11:00", length: 42, notes: "Amazing gift from Beth who is so totally amazing."}) #epcot
bethdive3 = beth.dives.create({date: "30/01/2017", time: "11:00", length: 42, notes: "Diving at Disney in the largest aquarium in the Northern Hemisphere! Incredible! Giant rays and turtles and hysterical to see the people watching us in the tank..."}) #epcot

tyronedive4 = tyrone.dives.create({date: "16/07/2017", time: "13:00", length: 49, notes: "Back in Crete and back To the wall! Fantastic to see it again. Just incredible."}) #nana beach wall

aldive2 = al.dives.create({date: "04/04/2018", time: "08:30", length: 44, notes: "Divemaster training dive"}) #atauro

bethdive4 = beth.dives.create({date: "14/04/2018", time: "09:00", length: 51, notes: "First dive in a while, nervous at first but settled down quick"}) #tulamben coral garden
aldive3 = al.dives.create({date: "14/04/2018", time: "09:00", length: 51, notes: "First dive in Bali, very pretty and lots of marine life"}) #tulamben coral garden
bethdive5 = beth.dives.create({date: "14/04/2018", time: "14:30", length: 53, notes: "Shipwreck much larger than anticipated. Swam next to a sea turtle, amazing!"}) #tulamben liberty wreck
aldive4 = al.dives.create({date: "14/04/2018", time: "14:30", length: 53, notes: "Wreck was very long, poor visibility"}) #tulamben liberty wreck

bethdive6 = beth.dives.create({date: "15/04/2018", time: "18:00", length: 51, notes: "Night dive at Liberty wreck super atmospheric. Some ear issues on ascent. Giant Moray eel!"}) #tulamben liberty wreck
aldive5 = al.dives.create({date: "15/04/2018", time: "18:00", length: 51, notes: "Night dive. Saw a HUGE Moray eel!"}) #tulamben liberty wreck

aldive6 = al.dives.create({date: "17/04/2018", time: "12:00", length: 50, notes: "A very important dive... there should be a webapp made in its' memory..."}) #menjangan ariel
bethdive7 = beth.dives.create({date: "17/04/2018", time: "12:00", length: 50, notes: "Super special dive! Let's make a webapp in its' memory!"}) #menjangan ariel

chrisdive5 = chris.dives.create({date: "14/05/2018", time: "10:00", length: 25, notes: "Back in Crete."}) #nana beach sandy flats
tyronedive5 = tyrone.dives.create({date: "14/05/2018", time: "10:00", length: 25, notes: "Back in Crete! Loving life in 2018!"}) #nana beach sandy flats

sarahdive4 = sarah.dives.create({date: "18/05/2018", time: "14:00", length: 49, notes: "Watch out guys, the PROFESSIONAL MERMAID is back!"}) #nana beach sandy flats

avidive1 = avi.dives.create({date: "26/06/2018", time: "10:30", length: 35, notes: "Hmm I think I like coding better than diving but okay."}) #coney island

beth.save
al.save
chris.save
sarah.save
avi.save
tyrone.save

grotto = Divesite.create({name: "Ariels Grotto", location: "Menjangan Island, Bali", country: "Indonesia"})
garden = Divesite.create({name: "Coral Garden", location: "Tulamaben, Bali", country: "Indonesia"})
liberty = Divesite.create({name: "Liberty Wreck", location: "Tulamaben, Bali", country: "Indonesia"})
epcot = Divesite.create({name: "Living Seas at Epcot", location: "Disneyworld", country: "U.S.A"})
timor = Divesite.create({name: "The Dropoff", location: "Atauro", country: "Timor Leste"})
flats = Divesite.create({name: "Sandy Flats", location: "Nana Beach, Crete", country: "Greece"})
plane = Divesite.create({name: "Plane Wreck", location: "Nana Beach, Crete", country: "Greece"})
pool = Divesite.create({name: "Training Pool", location: "Nana Beach, Crete", country: "Greece"})
wall = Divesite.create({name: "The Wall", location: "Nana Beach, Crete", country: "Greece"})
coney = Divesite.create({name: "Beach", location: "Coney Island", country: "U.S.A"})
gbr = Divesite.create({name: "Coral Garden", location: "Great Barrier Reef", country: "Australia"})
encounter = Divesite.create({name: "Seadragon Place", location: "Encounter Bay, Adelaide", country: "Australia"})
shark = Divesite.create({name: "Shark Point", location: "Newquay", country: "U.K"})
tropical = Divesite.create({name: "Palm Tree Crop", location: "Falmouth", country: "U.K"})
kalk = Divesite.create({name: "Peace Place", location: "Kalk Bay", country: "South Africa"})
plitvice = Divesite.create({name: "Big Lake", location: "Plitvice Lakes", country: "Croatia"})

bethdive1.update(divesite: flats)
bethdive2.update(divesite: plane)
bethdive3.update(divesite: epcot)
bethdive4.update(divesite: garden)
bethdive5.update(divesite: liberty)
bethdive6.update(divesite: liberty)
bethdive7.update(divesite: grotto)

aldive1.divesite = epcot
aldive2.divesite = timor
aldive3.divesite = garden
aldive4.divesite = liberty
aldive5.divesite = liberty
aldive6.divesite = grotto

chrisdive1.divesite = pool
chrisdive2.divesite = flats
chrisdive3.divesite = plane
chrisdive4.divesite = plane
chrisdive5.divesite = flats

avidive1.divesite = coney

sarahdive1.divesite = flats
sarahdive2.divesite = wall
sarahdive3.divesite = plane
sarahdive4.divesite = flats

tyronedive1.divesite = pool
tyronedive2.divesite = plane
tyronedive3.divesite = plane
tyronedive4.divesite = wall
tyronedive5.divesite = flats


bethdive1.save
bethdive2.save
bethdive3.save
bethdive4.save
bethdive5.save
bethdive6.save
bethdive7.save

aldive1.save
aldive2.save
aldive3.save
aldive4.save
aldive5.save
aldive6.save

chrisdive1.save
chrisdive2.save
chrisdive3.save
chrisdive4.save
chrisdive5.save

avidive1.save

sarahdive1.save
sarahdive2.save
sarahdive3.save
sarahdive4.save

tyronedive1.save
tyronedive2.save
tyronedive3.save
tyronedive4.save
tyronedive5.save
