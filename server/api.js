const path = require('path');
const jsonServer = require('json-server');

const server = jsonServer.create();
server.use(jsonServer.defaults());

const router = jsonServer.router(path.join(__dirname, 'db.json'));
server.use(router);

console.log('Listening on 4000');
server.listen(4000);