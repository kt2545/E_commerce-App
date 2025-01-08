const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth'); 
const Product = require('../models/product'); 

// Create a get request to search products and get them
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
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

// Create a post request route to rate the product
productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId === req.user._id) {
                product.ratings.splice(i, 1);
                break;
            }
        }
        
        const newRating = {
            userId: req.user._id, // Use _id for MongoDB ObjectID
            rating,
        };

        product.ratings.push(newRating);
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;
