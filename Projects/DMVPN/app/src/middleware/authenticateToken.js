const jwt = require('jsonwebtoken');
const Org = require('../models/org');


const authenticateToken = async (request, response, next) => {
    try {
        if (!request.headers.authorization) {
            console.error(`Unauthenticated request, ${request.method} ${request.originalUrl}`);
            return response.status(401).send({
                error: 'Unauthorized'
            });
        };

        const token = request.headers.authorization.replace('Bearer ', '');
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
        const org = await Org.findOne({ _id: decodedToken._id, 'tokens.token': token });
        if (!org) {
            throw new Error();
        };

        request.org = org;
        request.token = token;

        next();
    } catch (error) {
        console.error(`Unauthorized request, ${request.method} ${request.originalUrl}, token: ${request.headers.authorization.replace('Bearer ', '')} `);
        return response.status(403).send({
            error: 'Forbidden'
        });
    };
};


module.exports = authenticateToken;