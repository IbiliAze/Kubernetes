const app = require('./app');


// Port
const port = process.env.PORT || 5000;


// Listen
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});


