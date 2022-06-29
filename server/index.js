// import from packages
const express = require('express');
const mongoose = require('mongoose');

// import from other files
const authRouter = require('./routes/auth');

// init
const app = express();
const port = process.env.PORT || 3000;
const databaseUri = process.env.DATABASE_URI || process.env.MONGODB_URI || 'mongodb://localhost:27017/dev';

// middleware
app.use(authRouter);

app.get('/', function (req, res) {
    res.json({
        msg: 'Hello World'
    });
});

// Connections
mongoose.connect(databaseUri)
    .then(() => {
        console.log('MongoDB Connection Successful');
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(port, '0.0.0.0', () => {
    console.log(`connected at port ${port}`);
});
