use 20p-0051_4A

db.createCollection('cities')

db.createCollection('moviepeople_1000')

mongoimport --db 20p-0051_4A --collection cities --file /home/ayyzenn/Desktop/DB_Lab/Mongo/cities.jsonl

mongoimport --db 20p-0051_4A --collection moviepeople_1000 --file /home/ayyzenn/Desktop/DB_Lab/Mongo/moviepeople-1000.jsonl

db.cities.find({timezone:"Africa/Harare"}).pretty()

db.cities.find({population:{$gt:12985000}}).pretty()

db.cities.find({"location.longitude": -58.37723} , {location:1 , population:1 }).pretty()

db.cities.updateMany({ country:"PK","location.latitude":73.2122},{$set:{"population":55000}})

db.cities.deleteMany({country:"PK",timezone:"Asia/Karachi"})

db.moviepeople_1000.find({"info.birthname":"Freeman, Crispin McDougal"}).pretty()


