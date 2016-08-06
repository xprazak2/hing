import mongoose from 'mongoose';

const item = new mongoose.Schema({
  name: String,
  amount: String,
  location: String,
  expiry: Date,
  listId: { type: mongoose.Schema.ObjectId, ref: 'List' }
});

export default mongoose.model('Item', item);
