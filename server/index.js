// import from packages
const express = require('express');

// import from other files
const authRouter = require('./routes/auth');

// init
const app = express();
const PORT = 3000;

// middleware
app.use(authRouter);

app.get('/', function (req, res) {
    res.json({
        msg: 'Hello World'
    });
});

app.listen(3000, '0.0.0.0', () => {
    console.log(`connected at port ${PORT}`);
});
