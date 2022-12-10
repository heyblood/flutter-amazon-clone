// import from packages
const express = require('express');
const mongoose = require('mongoose');
// import from other files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');

// init
const app = express();
const port = parseInt(process.env.PORT) || 3000;
const mongodbUri = process.env.MONGODB_URI || 'mongodb://localhost:27017/amazon_clone';

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

// Connections
mongoose.connect(mongodbUri)
    .then(() => {
        console.log('MongoDB Connection Successful');
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(port, '0.0.0.0', () => {
    console.log(`connected at port ${port}`);
});
