import mongoose from 'mongoose';
import config from './config';

// use es6 promises with node 4.x
mongoose.Promise = Promise;

export default function() {
  mongoose.connect(config.database);
  mongoose.connection.on('error', () => {
    console.info('Could not connect to Mongo');
  });
}
