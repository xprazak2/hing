import mongoose from 'mongoose';

const user = new mongoose.Schema({
  name: { type: String, unique: true }
});

export default mongoose.model('User', user);
