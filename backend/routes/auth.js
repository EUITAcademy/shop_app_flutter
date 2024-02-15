import { Router } from 'express';

import bcrypt from 'bcryptjs';

import { DUMMY_SECRET } from '../util/auth-middleware.js';

import jwt from 'jsonwebtoken';

const router = Router();

// Dummy stored users
var storedUsers = [];

function createToken(email) {
    return jwt.sign({ email: email }, DUMMY_SECRET, { expiresIn: '2h' });
}

// Authenticate
router.post('/signup', async (req, res) => {

    const email = req.body.email;
    const password = req.body.password;
    try {

        const userExists = storedUsers.find(user => user.email === email);
        if (userExists) {
            return res.status(422).json({ message: 'User already exisits' });
        }

        const saltRounds = 10;
        const salt = await bcrypt.genSalt(saltRounds);
        const hashedpass = await bcrypt.hash(password, salt);

        storedUsers.push({
            email: email,
            password: hashedpass,
        })

        const authToken = createToken(email);

        // Create expiration
        const now = new Date();
        const expiration = new Date(now.setHours(now.getHours() + 2)).toISOString();

        res.status(200).json({ token: authToken, exp: expiration });

    } catch (error) {

    console.log(error);
        res.status(500).json({ message: 'Server error' });
    }

});


router.post('/login', async (req, res) => {

    const userEmail = req.body.email;
    const userPassword = req.body.password;

    const userExists = storedUsers.find(user => user.email === userEmail);

    if (!userExists) {
        return res.status(422).json({ message: 'No user found for this email' });
    }

    try {

        const storedUser = storedUsers.find((user) => user.email === userEmail);

        const isPasswordValid = bcrypt.compare(userPassword, storedUser.password);
        if (!isPasswordValid) {
            return res.status(422).json({ message: 'Wrong password provided' });
        }

        const authToken = createToken(userEmail);

        // Create expiration
        const now = new Date();
        const expiration = new Date(now.setHours(now.getHours() + 2)).toISOString();

        res.status(200).json({ token: authToken, exp: expiration });

    } catch (err) {
        console.log(err);

        return res.status(500).json({ message: 'Server error' });
    }
});



export default router;