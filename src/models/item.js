import mongoose from 'mongoose';
import { modelToView } from './rendering';

const item = new mongoose.Schema({
  name: String,
  amount: String,
  location: String,
  expiry: Date,
  listId: { type: mongoose.Schema.ObjectId, ref: 'List' }
});

item.methods.toView = function () {
  return modelToView(this, ['id', 'name', 'amount', 'location', 'expiry', 'listId']);
};

export default mongoose.model('Item', item);
