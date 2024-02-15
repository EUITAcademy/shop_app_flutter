import { Router } from 'express';

import fs from 'node:fs/promises';

const router = Router();

// Get products
router.get('/products', async (req, res) => {
    try {
        const fileContent = await fs.readFile('./data/dummy-items.json');
        const productsData = JSON.parse(fileContent);
        res.status(200).json({ products: productsData });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/product/:id', async (req, res) => {
    try {
        const fileContent = await fs.readFile('./data/dummy-items.json');
        const productsData = JSON.parse(fileContent);

        const product = productsData.find((item) => item.id === req.params.id);

        if (!product) {
            return res.status(404).json({ message: 'no product found' });
        }

        res.status(200).json({ product: product });

    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

export default router;