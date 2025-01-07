const express = require('express');
const adminRouter = express.Router();
const admin = require("../middlewares/admin"); // Updated path to admin middleware
const Product = require('../models/product'); // Ensure this path is correct

// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        console.log('Received product data:', req.body);

        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        
        console.log('Product added successfully:', product);
        res.json(product);
    } catch (e) {
        console.error('Error adding product:', e);
        res.status(500).json({ error: e.message });
    }
});

// Get all products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        console.error('Error fetching products:', e);
        res.status(500).json({ error: e.message });
    }
});

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => { 
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e) {
        console.error('Error deleting product:', e);
        res.status(500).json({ error: e.message });
    }
});

module.exports = adminRouter;
