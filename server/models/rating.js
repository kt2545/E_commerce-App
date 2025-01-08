const mongoose = require("mongoose");

const ratingSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    rating: {
        type: Number,
        required: true,
    },
});

const productSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    ratings: [ratingSchema],
});

const Product = mongoose.model("Product", productSchema);
module.exports = Product;
