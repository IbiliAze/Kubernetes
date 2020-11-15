const express = require('express');
const router = new express.Router();

const Config = require('../models/config');
const Site = require('../models/site');

const doesSiteExist = require('../middleware/doesSiteExist');
const doesConfigExist = require('../middleware/doesConfigExist');
const authenticateToken = require('../middleware/authenticateToken');


// Routes
// POST /api/config
router.post('/config', authenticateToken, async (request, response) => {
    try {
        const site = await Site.findOne({ _id: request.body.siteId, orgId: request.org._id });
        if (!site) {
            console.error(`Site not found, ID: ${request.body.siteId}`);
            return response.status(404).send({
                error: 'Site not found',
                ID: request.body['siteId'],
                ID: request.params.id
            });
        };

        const config = new Config({
            ...request.body,
            orgId: request.org._id
        });
        await config.save();
        console.log(`Config saved succesfully, ID: ${config._id}`);
        response.status(201).send({
            message: `Config saved succesfully`,
            ID: config._id
        });
    } catch(error) {
        console.error(error);
        response.status(400).send({
            error: error
        });
    };
});


// GET /api/config
router.get('/config', authenticateToken, async (request, response) => {
    try {
        if (request.query.siteId) {
            const siteId = request.query.siteId;

            const site = await Site.findOne({ _id: siteId, orgId: request.org._id });
            if (!site) {
                console.error(`Site not found, ID: ${siteId}`);
                return response.status(404).send({
                    error: 'Site not found',
                    ID: siteId
                });
            };

            const configs = await Config.find({ orgId: request.org._id, siteId: siteId });
            console.log(`Configs fetched successfully`);
            return response.status(200).send(configs);
        };
        const configs = await Config.find({ orgId: request.org._id });
        console.log(`Configs fetched successfully`);
        response.status(200).send(configs);
    } catch (error) {
        console.error(error);
        response.status(404).send({
            error: error
        });
    };
});


// GET /api/config by ID
router.get('/config/:id', authenticateToken, doesConfigExist, async (request, response) => {
    try {
        const config = await Config.findOne({ _id: request.params.id, orgId: request.org._id });
        await config.populate('siteId').execPopulate();
        console.log(`Config fetched successfully, ID: ${config._id}`);
        response.status(200).send(config);
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
});


// PUT /api/config by ID
router.put('/config/:id', authenticateToken, doesConfigExist, async (request, response) => {
    const updates = Object.keys(request.body);
    const allowedUpdates = ['encryption', 'hash', 'dhGroup', 'lifetime', "eigrp", "siteId", "credentials"];
    const isValidOperation = updates.every((update) => allowedUpdates.includes(update));
    if (!isValidOperation) {
        console.error(`Invalid update`);
        return response.status(400).send({error: `Invalid update`});
    };
    try {
        const config = await Config.findOne({ _id: request.params.id, orgId: request.org._id });
        updates.forEach((update) => config[update] = request.body[update] );
        await config.save();
        console.log(`Config updated successfully, ID: ${request.params.id}`);
        response.status(200).send({message: `Config updated successfully`, ID: request.params.id});
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
});


// DELETE /api/config by ID
router.delete('/config/:id', authenticateToken, doesConfigExist, async (request, response) => {
    try {
        const config = await Config.findOne({ _id: request.params.id, orgId: request.org._id });
        await config.remove();
        console.log(`Config deleted successfully, ID: ${request.params.id}`);
        response.status(200).send({message: `Config deleted successfully`, ID: request.params.id});
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
});



module.exports = router;