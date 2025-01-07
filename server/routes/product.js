const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth'); // Updated path to auth middleware
const Product = require('../models/product'); // Ensure correct path to Product model

// Route to search for products by name
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        // Perform a case-insensitive search for products by name
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        
        // Respond with the matching products
        res.json(products);
    } catch (e) {
        // Handle any errors that occur
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;
