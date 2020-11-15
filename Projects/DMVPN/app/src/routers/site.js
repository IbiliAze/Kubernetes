const express = require('express');
const router = new express.Router();

const Site = require('../models/site');

const doesSiteExist = require('../middleware/doesSiteExist');
const doesOrgExist = require('../middleware/doesOrgExist');
const authenticateToken = require('../middleware/authenticateToken');


// Routes
// POST /api/site
router.post('/site', authenticateToken, async (request, response) => {
    const site = new Site({
        ...request.body,
        orgId: request.org._id
    });
    try {
        await site.save();
        console.log(`Site saved succesfully, ID: ${site._id}`);
        response.status(201).send({
            message: `Site saved succesfully`,
            ID: site._id
        });
    } catch(error) {
        console.error(error);
        response.status(400).send({
            error: error
        });
    };
});


// GET /api/site
router.get('/site', authenticateToken, async (request, response) => {
    try {
        const sites = await Site.find({ orgId: request.org._id });
        console.log(`Sites fetched successfully`);
        response.status(200).send(sites);
    } catch (error) {
        console.error(error);
        response.status(404).send({
            error: error
        });
    };
});


// GET /api/site by ID
router.get('/site/:id', authenticateToken, doesSiteExist, async (request, response) => {
    const _id = request.params.id;
    try {
        const site = await Site.findOne({ _id, orgId: request.org._id });
        await site.populate('orgId').execPopulate();
        if (!site) {
            console.error(`Site not found, ID: ${_id}`);
            return response.status(404).send({
                error: 'Site not found',
                ID: request.params.id
            });
        };

        console.log(`Site fetched successfully, ID: ${site._id}`);
        response.status(200).send(site);
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
});


// PUT /api/site by ID
router.put('/site/:id', authenticateToken, doesSiteExist, async (request, response) => {
    const updates = Object.keys(request.body);
    const allowedUpdates = ['siteName'];
    const isValidOperation = updates.every((update) => allowedUpdates.includes(update));
    if (!isValidOperation) {
        console.error(`Invalid update`);
        return response.status(400).send({error: `Invalid update`});
    };
    try {
        const site = await Site.findOne({ _id: request.params.id, orgId: request.org._id });
        updates.forEach((update) => site[update] = request.body[update] );
        await site.save();
        console.log(`Site updated successfully, ID: ${request.params.id}`);
        response.status(200).send({message: `Site updated successfully`, ID: request.params.id});
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
});


// DELETE /api/site by ID
router.delete('/site/:id', authenticateToken, doesSiteExist, async (request, response) => {
    try {
        const site = await Site.findOne({ _id: request.params.id, orgId: request.org._id });
        await site.remove();
        console.log(`Site deleted successfully, ID: ${request.params.id}`);
        response.status(200).send({message: `Site deleted successfully`, ID: request.params.id});
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
});



module.exports = router;