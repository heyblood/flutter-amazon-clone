const express = require('express');

const authRouter = express.Router();

authRouter.post('/api/signup', (req, res) => {
    // get the data from client
    const {name, email, password} = req.body;

    // store that data in database

    // return that data to the user
});

module.exports = authRouter;
