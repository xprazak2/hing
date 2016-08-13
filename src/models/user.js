import mongoose from 'mongoose';
import { modelToView } from './rendering';

const user = new mongoose.Schema({
  name: { type: String, unique: true }
});

user.methods.modelToView = function () {
  return modelToView(this, ['name']);
};

export default mongoose.model('User', user);
