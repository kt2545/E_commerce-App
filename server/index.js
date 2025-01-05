// IMPORTS FROM PACKAGES
const express = require('express'); // Same as import 
const mongoose = require('mongoose');
const bcryptjs = require('bcryptjs');

// IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');

// INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://kapil:kapil123@cluster0.i75av.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

// Connections
mongoose
.connect(DB)
.then(() => {
    console.log("Connection Successful");
})
.catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});

app.get('/', (req, res) => {
    res.send('Hello World!');
    console.log('Root route accessed');
});

console.log('Server setup complete');
