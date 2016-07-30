import mongoose from 'mongoose';
import config from './config';

export default function() {
  mongoose.connect(config.database);
  mongoose.connection.on('error', () => {
    console.info('Could not connect to Mongo');
  });
}
