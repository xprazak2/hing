// import http from 'http';

import db from './db';
import config from './config';

import express from 'express';
import logger from 'morgan';
import path from 'path';
import nunjucks from 'nunjucks';
import bodyParser from 'body-parser';

db();
let app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

import listRoutes from './routes/list-routes';

app.use('/lists', listRoutes);

app.get('/sample', (req, res) => {
  res.send('This is a sample route!');
})

app.listen(config.port, () => {
  console.log('Server started: http://localhost:' + config.port);
});
