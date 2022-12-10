const express = require('express');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

const User = require('../models/user');
const auth = require('../middlewares/auth');

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

// check token is valid, return ture or false
authRouter.post('/api/verify-token', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.json(false);

        const verified = jwt.verify(token, 'passwordKey');
        if (!verified) return res.json(false);

        const user = User.findById(verified.id);
        if (!user) return res.json(false);

        res.json(true);
    } catch (e) {
        res.status(500).json({
            error: e.message
        });
    }
});


// get user data
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    if (!user) {
        return res.status(400).json({
            msg: 'No authorized user.'
        });
    }
    res.json({
        ...user._doc,
        token: req.token,
    });
});

module.exports = authRouter;
