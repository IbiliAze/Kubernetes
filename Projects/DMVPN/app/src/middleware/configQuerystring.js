const Config = require('../models/config');


const configQuerystring = async (request, response, next) => {
    try {
        if (request.query) {
            const queryKeys = Object.keys(request.query);

            const sort = {};
            const limit = request.query.limit;
            const sortBy = request.query.sortBy;

            const allowedQueries = ['siteId', 'eigrp', 'eigrpAsn', 'createdAt', 'updatedAt', 'limit', 'sortBy'];
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
            const configs = await Config.find({
                orgId: request.org._id,
                ...request.query
            }).limit(Number(limit)).sort(sort);
            
            console.log(`Configs fetched successfully`);
            return response.status(200).send(configs);
        };
    } catch (error) {
        console.error(error);
        response.status(500).send({
            error: error
        });
    };
};


module.exports = configQuerystring;