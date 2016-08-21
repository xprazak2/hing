import mongoose from 'mongoose';
import { modelToView } from './rendering';

const item = new mongoose.Schema({
  name: { type: String, required: true },
  amount: String,
  location: String,
  expiry: Date,
  listId: { type: mongoose.Schema.ObjectId, ref: 'List', required: true }
}, {
  timestamps: true
});

item.methods.toView = function () {
  return modelToView(this, ['id', 'name', 'amount', 'location',
                            'expiry', 'listId', 'createdAt', 'updatedAt']);
};

export default mongoose.model('Item', item);
