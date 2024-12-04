const mongoose = reqire('mongoose');

const userSchema = mongoose.Scheme({
    name: {
        reqired: true,
        type: String,
        trim: true,
    },
    email: {
        reqired: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
             const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$/;
             value.match(re);

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

const User = mongoose.model("User",userSchema);
module.exports = User;