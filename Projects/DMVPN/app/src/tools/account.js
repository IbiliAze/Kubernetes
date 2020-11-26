const sgMail = require('@sendgrid/mail');


const sendgridAPIKey = process.env.SENDGRID_API_KEY;


sgMail.setApiKey(sendgridAPIKey);


const sendWelcomeEmail = async (email, name) => {
    try {
        await sgMail.send({
            to: email,
            from: process.env.LOCAL_EMAIL,
            subject: `Welcome to Afenia, ${name}`,
            text: `Welcome, ${name}!` 
        });
    } catch (error) {
        console.log(error);
    };    
};


const sendGoodbyeEmail = async (email, name) => {
    try {
        await sgMail.send({
            to: email,
            from: process.env.LOCAL_EMAIL,
            subject: `Goodbye, ${name}`,
            text: `Sad to see you go, ${name}!` 
        });
    } catch (error) {
        console.log(error);
    };
};


module.exports = {
    sendWelcomeEmail,
    sendGoodbyeEmail
};