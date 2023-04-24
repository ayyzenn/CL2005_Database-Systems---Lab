db.cities.find({population:{$lt:30 , $ne:0}}).limit(2).forEach(printjson);

db.cities.find({timezone:"Asia/Jakarta"}).count();

db.cities.find({country:"PK",timezone:"Asia/Karachi"},{country:1,timezone:1 , population:1}).sort({population:-1}).forEach(printjson);


db.cities.getIndexes();
db.cities.createIndex({population:1});
db.cities.dropIndex({population:1});



{timezone:"Europe/Andorra"}

{population:{$gt:12955000},country:"AR"}


{"location.latitude":{$eq:1.6}}

{location:1 , population:1} --projection