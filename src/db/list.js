import mongoose from 'mongoose';

const list = new mongoose.Schema({
  name: { type: String, unique: true },
  userId: { type: mongoose.Schema.ObjectId, ref: 'User' }
}, {
  timestamps: true
});

export default mongoose.model('List', list);
