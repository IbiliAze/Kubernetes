const mongoose = require('mongoose');
const validator = require('validator');
const Config = require('./config');


const siteSchema = new mongoose.Schema({
    siteName: {
        type: String,
        required: true,
        validate(value) {
            if (value.length < 2) {
                console.error(`Site Name is too short`);
                throw new Error(`Site Name is too short`);
            }
        }
    },
    orgId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'Org'
    },
    description: {
        type: String,
        required: false,
        default: "Site description"
    },
    type: {
        type: String,
        required: false,
        default: 'HQ'
    },
    department: {
        type: String,
        required: false,
        default: 'IT'
    },
    floor: {
        type: String,
        required: false
    }
});


siteSchema.methods.toJSON = function () {
    const site = this;
    const siteObject = site.toObject();
   
    delete siteObject.tokens;
    delete siteObject.__v;
    delete siteObject.orgId.password;
    delete siteObject.orgId.tokens;
    delete siteObject.orgId.__v;

    return siteObject;
};


siteSchema.pre('remove', async function (next) {
    const site = this;
    await Config.deleteMany({ siteId: site._id, orgId: site.orgId });

    next();
});


const Site = mongoose.model('Site', siteSchema);



module.exports = Site;