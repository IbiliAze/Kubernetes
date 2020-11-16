const mongoose = require('mongoose');

const databaseName = 'DMVPN';
const connectionURL = `mongodb://10.8.0.72:27017/${databaseName}`;

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

