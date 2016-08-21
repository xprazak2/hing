import mongoose from 'mongoose';
import { modelToView } from './rendering';

const list = new mongoose.Schema({
  name: { type: String, unique: true, required: true },
  userId: { type: mongoose.Schema.ObjectId, ref: 'User' }
}, {
  timestamps: true
});

// cannot handle arrow function - outer this set to undefined
list.methods.toView = function () {
  return modelToView(this, ['id', 'name', 'createdAt', 'updatedAt']);
};

export default mongoose.model('List', list);
