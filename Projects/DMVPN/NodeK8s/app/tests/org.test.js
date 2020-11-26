const request = require('supertest');

const app = require('../src/app');
const Org = require('../src/models/org');

const { orgOne, orgOneId, setupDatabase } = require('./fixtures/db');


// Before each test
beforeEach(setupDatabase);


// Tests
// POST
test('Should signup a new Organization', async () => {
    const response = await request(app).post('/api/org').send({
        orgName: "Afenia",
        email: 'thisIsForJestTesting@mail.com',
        password: "cisco12345"
    }).expect(201);

    const org = await Org.findById(response.body.ID);
    
    // Make sure the organization is created
    expect(org).not.toBeNull();
});


test('Should sign in an existing Organization', async () => {
    const response = await request(app).post('/api/org/token').send({
        email: orgOne.email,
        password: orgOne.password
    }).expect(200);

    const org = await Org.findById(response.body.ID);

    // Make sure the token received is the second token in the tokens array
    expect(response.body.token).toBe(org.tokens[1].token);
});


test('Should not signup a new Organization with password.length < 8', async () => {
    await request(app).post('/api/org').send({
        orgName: "Afenia",
        email: 'thisIsForJestTesting3@mail.com',
        password: "cisco"
    }).expect(400);
});


test('Should not sign in a failed authentication password', async () => {
    await request(app).post('/api/org/token').send({
        email: orgOne.email,
        password: 'rougepassword'
    }).expect(400);
});


test('Should not sign in a non-existent Organization', async () => {
    await request(app).post('/api/org/token').send({
        email: 'rougeemail',
        password: 'rougepassword'
    }).expect(400);
});


// GET
test('Should get Organization profile', async() => {
    const response = await request(app)
        .get('/api/org')
        .set('Authorization', `Bearer ${orgOne.tokens[0].token}`)
        .send()
        .expect(200);

    const org = await Org.findById(response.body._id);

    // Test for non-hashed passwords
    expect(org.password).not.toBe(orgOne.password);

    // Test saved organization ID equals to the ID we set manually
    expect(org._id).toStrictEqual(orgOne._id);
});


test('Should not get Organization profile for non-authenticated requests', async() => {
    await request(app)
        .get('/api/org')
        .send()
        .expect(401);
});


test('Should not get Organization profile for non-authorized requests', async() => {
    await request(app)
        .get('/api/org')
        .set('Authorization', 'rougetoken')
        .send()
        .expect(403);
});


// PUT
test('Should update an Organization profile: orgName', async () => {
    const response = await request(app)
        .put('/api/org')
        .set('Authorization', `Bearer ${orgOne.tokens[0].token}`)
        .send({
            orgName: 'AfeniaUpdated'
        })
        .expect(200);
    
    const org = await Org.findById(orgOneId);

    // Make sure the update took place
    expect(org.orgName).toEqual('AfeniaUpdated');
});


test('Should not update an Organization profile: email', async () => {
    await request(app)
        .put('/api/org')
        .set('Authorization', `Bearer ${orgOne.tokens[0].token}`)
        .send({
            email: 'email@mail.com'
        })
        .expect(400);
});


test('Should not update Organization profile for non-authenticated requests', async() => {
    await request(app)
        .put('/api/org')
        .send({
            orgName: 'AfeniaUpdated'
        })
        .expect(401);
});


test('Should not delete Organization profile for non-authorized requests', async() => {
    await request(app)
        .put('/api/org')
        .set('Authorization', 'rougetoken')
        .send({
            orgName: 'AfeniaUpdated'
        })
        .expect(403);
});


// DELETE
test('Should delete an Organization profile', async () => {
    const response = await request(app)
        .delete('/api/org')
        .set('Authorization', `Bearer ${orgOne.tokens[0].token}`)
        .send()
        .expect(200);

    const org = await Org.findById(response.body.ID);

    // Make sure the organization does not exist
    expect(org).toBeNull();
});


test('Should not delete Organization profile for non-authenticated requests', async() => {
    await request(app)
        .delete('/api/org')
        .send()
        .expect(401);
});


test('Should not delete Organization profile for non-authorized requests', async() => {
    await request(app)
        .delete('/api/org')
        .set('Authorization', 'rougetoken')
        .send()
        .expect(403);
});