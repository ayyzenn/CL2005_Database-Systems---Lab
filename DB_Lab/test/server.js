const express = require('express')
const colors = require('colors')
const dotenv = require('dotenv').config()
const {errorHandler} = require('./middleware/errorMiddleware')
const connectDB = require('mongoose')
const port = process.env.PORT || 5000

connectDB.connect('mongodb://127.0.0.1/nodekb');
let db = connectDB.connection;

// check connection
db.once('open',function(){
  console.log('Connceted to MongDB');
});

// check for db errors
db.on('error' , function(err){
  console.log(err);
});

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use('/api/goals' , require('./routes/goalRoutes'))

app.use(errorHandler)


app.listen(port, () => {
    console.log(`Server strated on port ${port}`);
  });
  