const request = require('supertest');

const app = require('../src/app');
const Site = require('../src/models/site');

const { 
    orgOne, 
    orgOneId, 
    orgTwo,
    orgTwoId,
    siteOne,
    siteTwo,
    siteThree,
    setupDatabase 
} = require('./fixtures/db');


// Before each test
beforeEach(setupDatabase);


// Tests
// POST
test('Should create a new site', async () => {
    const response = await request(app)
        .post('/api/site')
        .set('Authorization', `Bearer ${orgOne.tokens[0].token}`)
        .send({
            siteName: 'TestSite'
        })
        .expect(201);

    const site = await Site.findById(response.body.ID);

    // Make sure the site is created
    expect(site).not.toBe(null);
});


// GET
test('OrgOne should have sites', async () => {
    const response = await request(app)
        .get('/api/site')
        .set('Authorization', `Bearer ${orgOne.tokens[0].token}`)
        .expect(200);
    
    const sites = Site.find({ orgId: orgOneId });

    expect(response.body.length).toBe(2);
});


// DELETE
test('Should not delete other organizations sites', async () => {
    const response = await request(app)
        .delete(`/api/site/${siteOne._id}`)
        .set('Authorization', `Bearer ${orgTwo.tokens[0].token}`)
        .send()
        .expect(404);

    const site = await Site.findById(siteOne._id);
    
    // Site belonging to the other organization should still exist
    expect(site).not.toBe(null);
}); 