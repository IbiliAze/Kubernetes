const Site = require('../models/site');

const doesSiteExist = async (request, response, next) => {
    try {
        const site = await Site.findOne({ _id: request.params.id, orgId: request.org._id });
        if (!site) {
            console.error(`Site not found, ID: ${request.params.siteId}`);
            return response.status(404).send({
                error: 'Site not found',
                ID: request.body['siteId'],
                ID: request.params.id
            });
        };
        next();
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
};

module.exports = doesSiteExist; 