const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../models/user');

const authRouter = express.Router();

// SIGN UP
authRouter.post('/api/signup', async (req, res) => {
    try {
        const {
            name,
            email,
            password
        } = req.body;

        const existedUser = await User.findOne({
            email
        });
        if (existedUser) {
            return res.status(400).json({
                msg: 'A user with the same email already exists!'
            });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            name,
            password: hashedPassword,
            email
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({
            error: e.message
        });
    }
});

module.exports = authRouter;
