const express = require('express');
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require('../models/product'); // Import Product model

// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        console.log('Received product data:', req.body); // Log incoming data

        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        
        console.log('Product added successfully:', product); // Log saved product
        res.json(product);
    } catch (e) {
        console.error('Error adding product:', e); // Log errors
        res.status(500).json({ error: e.message });
    }
});

// Get all products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        console.error('Error fetching products:', e); // Log errors
        res.status(500).json({ error: e.message });
    }
});

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => { // Ensure route consistency
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e) {
        console.error('Error deleting product:', e); // Log errors
        res.status(500).json({ error: e.message });
    }
});

module.exports = adminRouter;
