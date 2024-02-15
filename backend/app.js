import express from 'express';
import bodyParser from 'body-parser';
import authMiddleware from './util/auth-middleware.js';

import authRoutes from './routes/auth.js';
import productsRoutes from './routes/products.js';

import cors from 'cors';

const app = express();
app.use(bodyParser.json());

app.use(express.static('./img'));
app.use(cors());

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    // res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

// login and signup
app.use(authRoutes);

// Checks auth headers
app.use(authMiddleware);

// Products routes
app.use(productsRoutes);

// Order dummy post request
// returns 200 if we have any order object
app.post('/order', async (req, res) => {
    const order = req.body.order;
    if (!order) {
        return res.status(400).json({ message: 'Bad request' });
    }
    return res.status(200).json({ message: 'Order placed successfully!' });
});

// Error handler function 
app.use(async (error, req, res, next) => {
    const status = error.status ?? 500;
    const message = error.message ?? 'Error';
    return res.status(status).json({ message: message, status: status});
});

//The 404 Route 
app.get('*', function (req, res) {
    res.status(404).json({ message: '404 Not Found' });
});

app.listen(8080);
