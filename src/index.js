import db from './db';
import config from './config';
import { logger, expressLogger } from './logging';

import express from 'express';
import bodyParser from 'body-parser';
import path from 'path';

db.connect();
let app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Set view path
// app.set('views', path.join(__dirname, 'views'));
// set up ejs for templating. You can use whatever
// app.set('view engine', 'ejs');

// serve static files
app.use(express.static('./dist'));

// webpack fragment
import webpack from 'webpack';
import webpackDevMiddleware from 'webpack-dev-middleware';
import webpackConfig from '../webpack.config.js';

if (config.env === 'development') {
  const compiler = webpack(webpackConfig);

  app.use(webpackDevMiddleware(compiler, {
    publicPath: webpackConfig.output.publicPath,
    noInfo: true
    // stats: {
    //   colors: true,
    //   hash: false,
    //   timings: true,
    //   chunks: false,
    //   chunkModules: false,
    //   modules: false
    // }
  }));
}

// middleware logger goes before all routes!
app.use(expressLogger);

// import and mount routes !!! All middleware goes BEFORE this !!!
import listRoutes from './routes/list-routes';
import itemRoutes from './routes/item-routes';

app.use('/api/lists', listRoutes);
app.use('/api/items', itemRoutes);

// create home route - TODO: move to a separate route file
app.use('/', function (req, res) {
    res.sendFile(path.resolve('./src/views/index.html'));
});

// error logger will be after routes and before any error handlers
// app.use(expressErrorLogger);

app.listen(config.port, () => {
  logger.info('Server started: http://localhost:' + config.port);
});
