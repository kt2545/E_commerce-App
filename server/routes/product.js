const express = require('express');
const productRouter = express.Router();
const auth = require('../middleware/auth'); // Correct path to auth middleware
const Product = require('../models/product'); // Ensure correct path to Product model

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;
