import config from '../src/config';

import express from 'express';
import bodyParser from 'body-parser';

let app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

import listRoutes from '../src/routes/list-routes';
import itemRoutes from '../src/routes/item-routes';

app.use('/lists', listRoutes);
app.use('/items', itemRoutes);

export default app;
