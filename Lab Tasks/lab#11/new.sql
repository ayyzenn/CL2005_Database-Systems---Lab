use p20_0051_4A

db.createCollection("users")


db.users.insert({ "username":"Ali" , "password":"def321" , "email":"ali123@yahoo.com" , "DOB":"1996-03-04" , "Address":"Peshawar" , "Contact":"+923332233322"})

db.users.insert({ "username":"Haroon" , "password":"fast123" , "email":"haroon@gmail.com" , "Address":"Karachi" })

db.users.insert({ "username":"Zain" , "password":"Abc123" , "email":"zain@gmail.com" , "DOB":"1997-02-13" , "Address":"Islamabad" })

db.users.insert({ "username":"Atif" , "password":"Qwe123" , "email":"atif@gmail.com" , "Address":"Address" , "Contact":"+923139834276"})

db.users.insert({ "username":"Noman" , "password":"def321" , "email":"noman@gmail.com" , "DOB":"1996-03-04" , "Address":"Peshawar" , "Contact":"+923349056432"})


db.users.find().pretty()


db.users.find({ Address: "Islamabad" }).pretty()


db.users.find( { Address: { $in: [ "Peshawar", "Karachi" ] } }).pretty()


