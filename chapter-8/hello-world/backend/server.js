const express = require('express');
const mongodb = require('mongodb');
const cors = require('cors');
const app = express();
const PORT = 3000;
const DB_URI = 'mongodb://mongodb:27017/helloworldapp';

app.use(cors());
app.use(express.json());

app.get('/api/helloworlds', async (req, res) => {
    const client = await mongodb.MongoClient.connect(DB_URI, { useNewUrlParser: true, useUnifiedTopology: true });
    const collection = client.db().collection('greetings');
    const greetings = await collection.find({}).toArray();
    res.json(greetings);
    client.close();
});

// Expose app for testing
module.exports = app;

// Listen on PORT if this script is run directly
if (require.main === module) {
    app.listen(PORT, '0.0.0.0', () => {
        console.log(`Server running on port ${PORT}`);
    });
}
