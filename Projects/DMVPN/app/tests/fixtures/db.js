const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');
const Org = require('../../src/models/org');
const Site = require('../../src/models/site');


// To use the ordId locally so we can send the token in a header
const orgOneId = new mongoose.Types.ObjectId();
const orgOne = {
    _id: orgOneId,
    email: 'thisIsForJestTestin2g@mail.com',
    orgName: 'Afenia2',
    password: 'cisco12345',
    tokens: [
        {
            token: jwt.sign({ _id: orgOneId }, process.env.JWT_SECRET)
        }
    ]
};

const orgTwoId = new mongoose.Types.ObjectId();
const orgTwo = {
    _id: orgTwoId,
    email: 'thisIsForJestTestinAnother@mail.com',
    orgName: 'AfeniaAnother',
    password: 'cisco1234567',
    tokens: [
        {
            token: jwt.sign({ _id: orgTwoId }, process.env.JWT_SECRET)
        }
    ]
};


const siteOne = {
    _id: new mongoose.Types.ObjectId(),
    siteName: 'SiteName2',
    description: 'description',
    orgId: orgOneId
};


const siteTwo = {
    _id: new mongoose.Types.ObjectId(),
    siteName: 'SiteName3',
    description: 'description3',
    orgId: orgOneId
};


const siteThree = {
    _id: new mongoose.Types.ObjectId(),
    siteName: 'SiteName4',
    description: 'description4',
    orgId: orgTwoId
};


const setupDatabase = async () => {
    await Org.deleteMany();
    await Site.deleteMany();
    await new Org(orgOne).save();
    await new Org(orgTwo).save();
    await new Site(siteOne).save();
    await new Site(siteTwo).save();
    await new Site(siteThree).save();
};


module.exports = {
    orgOne,
    orgOneId,
    orgTwo,
    orgTwoId,
    siteOne,
    siteTwo,
    siteThree,
    setupDatabase
};