import http from 'http';
import db from './db';

// import List from './db/list';
// import Item from './db/item';
// import User from './db/user';

db();

http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from Node server!!');
}).listen(3000, '127.0.0.1');

console.log('Server running at http://127.0.0.1:3000');
