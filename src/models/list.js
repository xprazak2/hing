import mongoose from 'mongoose';

const list = new mongoose.Schema({
  name: { type: String, unique: true },
  userId: { type: mongoose.Schema.ObjectId, ref: 'User' }
}, {
  timestamps: true
});

// cannot handle arrow function - outer this set to undefined
list.methods.toView = function () {
  return ['id', 'name', 'createdAt', 'updatedAt'].reduce((memo, attr) => {
    memo[attr] = this[attr];
    return memo;
  }, {});
}

export default mongoose.model('List', list);
