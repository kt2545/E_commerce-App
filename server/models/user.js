// e_commerce_app/server/models/user.js
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: {
        required: true, // Corrected spelling
        type: String,
        trim: true,
    },
    email: {
        required: true, // Corrected spelling
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$/;
                return value.match(re);
            },
            message: 'Please enter a valid email address',
        },
    },
    password: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    // cart
});

const User = mongoose.model("User", userSchema); // Added space after comma
module.exports = User;
