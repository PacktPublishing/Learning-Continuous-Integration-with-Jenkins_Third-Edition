const chai = require('../backend/node_modules/chai');
const chaiHttp = require('../backend/node_modules/chai-http');
const sinon = require('../backend/node_modules/sinon');
const mongodb = require('../backend/node_modules/mongodb');
const app = require('../backend/server');

chai.use(chaiHttp);
const expect = chai.expect;

describe('Hello World API', function() {
    // Create a stub for MongoDB
    let connectStub;
    before(() => {
        connectStub = sinon.stub(mongodb.MongoClient, 'connect').resolves({
            db: function() {
                return {
                    collection: function() {
                        return {
                            find: function() {
                                return {
                                    toArray: async function() {
                                        return [
                                            { language: 'English', greeting: 'Hello World' }
                                        ];
                                    }
                                };
                            }
                        };
                    },
                    close: function() {}
                };
            }
        });
    });

    after(() => {
        connectStub.restore();
    });

    it('should return an array of greetings', async function() {
        const res = await chai.request(app).get('/api/helloworlds');
        expect(res).to.have.status(200);
        expect(res.body).to.be.an('array');
        expect(res.body[0]).to.have.property('language');
        expect(res.body[0]).to.have.property('greeting');
    });
});
