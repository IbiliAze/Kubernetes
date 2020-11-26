const mongoose = require('mongoose');

const databaseName = process.env.DATABASE_NAME;
const connectionURL = `mongodb://${process.env.MONGOOSE_URL}/${databaseName}`;

mongoose.connect(connectionURL, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useUnifiedTopology: true,
}, (error, client) => {
    if (error) {
        return console.error(`Connection error`);
    } 
    console.log(`Connection successful`);
});

