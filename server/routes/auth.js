const express = require('express');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

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


// SIGN IN
authRouter.post('/api/signin', async (req, res) => {
    try {
        const {
            email,
            password
        } = req.body;

        const user = await User.findOne({
            email
        });
        if (!user) {
            return res.status(400).json({
                msg: 'A user with this email dose not exist!'
            });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({
                msg: 'Incorrect password.'
            });
        }

        const token = jwt.sign({
            id: user._id
        }, 'passwordKey');

        res.json({
            token,
            ...user._doc
        });
    } catch (e) {
        res.status(500).json({
            error: e.message
        });
    }
});

module.exports = authRouter;
