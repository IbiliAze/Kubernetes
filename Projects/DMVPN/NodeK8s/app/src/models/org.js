const mongoose = require('mongoose');
const validator = require('validator');
const jwt = require('jsonwebtoken');
const bycrypt = require('bcryptjs');

const Site = require('./site');
const Config = require('./config');


const orgSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true,
        validate(value){
            if (!validator.isEmail(value)) {
                console.error('Invalid Email');
                throw new Error('Invalid Email');
            };
        }
    },
    password: {
        type: String,
        required: true,
        validate(value) {
            if (value.length < 8) {
                console.log(`Organization Password is too short`);
                throw new Error(`Organization Password is too short`);
            }
        }
    },
    orgName: {
        type: String,
        required: true,
        validate(value) {
            if (value.length < 2) {
                console.log(`Organization Name is too short`);
                throw new Error(`Organization Name is too short`);
            }
        }
    },
    tokens: [
        {
            token: {
                type: String,
                required: true
            }
        }
    ]
}, {
    timestamps: true
});


orgSchema.virtual('sites', {
    ref: 'Site',
    localField: '_id',
    foreignField: 'orgId'
});


orgSchema.methods.toJSON = function () {
    const org = this;
    const orgObject = org.toObject();
   
    delete orgObject.tokens;
    delete orgObject.__v;
    delete orgObject.password;

    return orgObject;
};


orgSchema.methods.generateAuthToken = async function() {
    const org = this;
    const token = jwt.sign({ _id: org._id.toString() }, process.env.JWT_SECRET );

    org.tokens = org.tokens.concat({ token });
    await org.save();

    return token;
};


orgSchema.pre('save', async function (next) {
    const org = this;
    if (org.isModified('password')) {
        org.password = await bycrypt.hash(org.password, 8);
    };

    next();
});


orgSchema.pre('remove', async function (next) {
    const org = this;
    await Site.deleteMany({ orgId: org._id });
    await Config.deleteMany({ orgId: org._id });

    next();
});


orgSchema.statics.findByCredentials = async function (email, password) {
    const org = await Org.findOne({ email });
    if (!org) {
        throw new Error(`Organization with ID: ${org._id} does not exist`);
    };

    const isMatch = await bycrypt.compare(password, org.password);
    if (!isMatch) {
        throw new Error(`Authentication failed, ID: ${org._id}`);
    };

    return org;
};


const Org = mongoose.model('Org', orgSchema);


module.exports = Org;