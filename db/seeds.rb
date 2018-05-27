User.destroy_all
Dive.destroy_all
Divesite.destroy_all

beth = User.create({first_name: "Beth", last_name: "Schofield", username: "gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})
al = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "password"})
chris = User.create({first_name: "Chris", last_name: "Zoumadakis", username: "chreece_from_greece", email: "chris@greece.com", password: "password"})
sarah = User.create({first_name: "Sarah", last_name: "Jaban", username: "mermaid_princess", email: "sarah@mermaids.com", password: "password"})

beth.save
al.save
chris.save
sarah.save

bethdive1 = beth.dives.create({date: "01/03/2004"})
bethdive2 = beth.dives.create({date: "02/11/2017"})
aldive1 = al.dives.create({date: "01/03/2013"})
aldive2 = al.dives.create({date: "21/02/2018"})
chrisdive1 = chris.dives.create({date: "01/03/2013"})
chrisdive2 = chris.dives.create({date: "21/03/2001"})
sarahdive1 = sarah.dives.create({date: "16/06/2015"})
sarahdive2 = sarah.dives.create({date: "23/06/2015"})

beth.save
al.save
chris.save
sarah.save

grotto = Divesite.create({name: "Ariels Grotto", location: "Menjangan Island, Bali", country: "Indonesia"})
epcot = Divesite.create({name: "Living Seas at Epcot", location: "Disneyworld", country: "U.S.A"})
dropoff = Divesite.create({name: "The Dropoff", location: "Atuauro", country: "Timor Leste"})
flats = Divesite.create({name: "Sandy Flats", location: "Nana Beach, Crete", country: "Greece"})
mermaid_grove = Divesite.create({name: "Mermaid Grove", location: "Fantasy Island", country: "My Mind"})

bethdive1.divesite = grotto
bethdive2.divesite = epcot
aldive1.divesite = grotto
aldive2.divesite = dropoff
chrisdive1.divesite = flats
chrisdive2.divesite = dropoff
sarahdive1.divesite = flats
sarahdive2.divesite = mermaid_grove

bethdive1.save
bethdive2.save
aldive1.save
aldive2.save
chrisdive1.save
chrisdive2.save
sarahdive1.save
sarahdive2.save
