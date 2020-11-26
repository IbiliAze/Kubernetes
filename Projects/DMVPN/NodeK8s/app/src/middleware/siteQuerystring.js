const Site = require('../models/site');


const siteQuerystring = async (request, response, next) => {
    try {
        if (request.query) {
            const queryKeys = Object.keys(request.query);

            const sort = {};
            const limit = request.query.limit;
            const sortBy = request.query.sortBy;

            const allowedQueries = ['description', 'type', 'department', 'siteName', 'floor', 'createdAt', 'updatedAt', 'limit', 'sortBy'];
            const isValidQuery = queryKeys.every((query) => allowedQueries.includes(query));
            if (!isValidQuery){
                console.error(`Invalid query: ${queryKeys}`);
                return response.status(400).send({ error: `Invalid query`, allowedQueries });
            };

            if (request.query.sortBy) {
                const allowedSortByValues = ['createdAt:asc', 'createdAt:desc', 'updatedAt:asc', 'updatedAt:desc'];
                const isValidQuery2 = allowedSortByValues.includes(sortBy);
                if (!isValidQuery2) {
                    console.error(`Invalid query: ${sortBy}`);
                    return response.status(400).send({ error: `Invalid sort options`, allowedSortByValues });
                };
                const parts = sortBy.split(':');
                sort[parts[0]] = parts[1] === 'desc' ? -1 : 1
            };

            delete request.query.limit;
            delete request.query.sortBy;
            const sites = await Site.find({
                orgId: request.org._id,
                ...request.query
            }).limit(Number(limit)).sort(sort);
            
            console.log(`Sites fetched successfully`);
            return response.status(200).send(sites);
        };
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
};


module.exports = siteQuerystring;