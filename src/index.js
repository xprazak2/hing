import db from './db';
import config from './config';
import { logger, expressLogger } from './logging';

import express from 'express';
import bodyParser from 'body-parser';

db();
let app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// middleware logger goes before all routes!
app.use(expressLogger);

import listRoutes from './routes/list-routes';

app.use('/lists', listRoutes);

app.get('/sample', (req, res) => {
  res.send('This is a sample route!');
});

// error logger will be after routes and before any error handlers
// app.use(expressErrorLogger);

app.listen(config.port, () => {
  logger.info('Server started: http://localhost:' + config.port);
});
