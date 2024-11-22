// IMPORTS FROM PACKAGES
const express = require('express'); //same as import 
const mongoose = require('mongoose');
//IMPORTS FROM OTHER FILES
const authRouter = require(',/routes/auth');

// INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://kapiltiwari2025:Kapil@2001@cluster0.i75av.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// middleware
app.use(authRouter);

// Connections
mongoose
.connect(DB)
.then( () => {
    console.log("Connection Successful");
    console.log("Connection Successful");

})
.catch( (e) => {
    console.log(e);
});

app.listen(PORT , () => {
    console.log('connected at port ${PORT}');
});

