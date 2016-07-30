import db from './src/db';
import mongoose from 'mongoose';
import List from './src/db/list';
import User from './src/db/user';
import Item from './src/db/item';
import gulp from 'gulp';
import async from 'async';
import gutil from 'gulp-util';

const userName = "admin";
const listName = 'The List';
const itemObjs = [
  {
    name: 'rope',
    amount: '10 m',
    location: '4B',
    expiry: null
  },
  {
    name: 'rice',
    amount: '1 kg',
    location: 'cellar',
    expiry:  new Date('2017-05-05')
  },
  {
    name: 'peaches',
    amount: '540 ml',
    location: 'top shelf',
    expiry: new Date('2017-01-02')
  }
];

const dbConnect = (callback) => {
  db();
  callback(null);
}

const seedUser = (callback) => {
  User.findOne({ name: userName}, (err, user) => {
    if (err) {
      callback(err);
    }
    if (!user) {
      let newUser = User({
        name: userName
      });
      newUser.save((err) => {
        if (err) {
          callback(err);
        }
        callback(null, newUser);
      });
    } else {
      callback(null, user);
    }
  });
};

const seedList = (user, callback) => {
  List.findOne({ name: listName }, (err, list) => {
    if (err) {
      throw err;
    }
    if (!list) {
      let newList = List({
        name: listName,
        userId: user.id
      });
      newList.save((err) => {
        if (err) {
          callback(err);
        }
        callback(null, newList);
      });
    } else {
      callback(null, list);
    }
  });
};

const seedItems = (list, callback) => {
  async.each(itemObjs, (itemObj, innerCallback) => {
    Item.findOne({ name: itemObj.name }, (err, itemRecord) => {
      if (err) {
        callback(err);
      }
      if (!itemRecord) {
        itemObj.listId = list.id;
        let item = Item(itemObj);
        item.save((err) => {
          if (err) {
            callback(err);
          }
          innerCallback(null);
        });
      } else {
        innerCallback(null);
      }
    });
  }, (err) => {
    callback(null);
  });
};

const clearItems = (callback) => {
  async.each(itemObjs, (itemObj, innerCallback) => {
    Item.findOneAndRemove({ name: itemObj.name }, (err) => {
      if (err) {
        callback(err);
      }
      innerCallback(null);
    });
  }, (err) => {
    callback(null);
  });
};

const clearList = (callback) => {
  List.findOneAndRemove({ name: listName }, (err) => {
    if (err) {
      callback(err);
    }
    callback(null);
  });
};

const clearUser = (callback) => {
  User.findOneAndRemove({ name: userName }, (err) => {
    if (err) {
      throw err;
    }
    callback(null);
  });
};

gulp.task('sampleSeed', () => {
  async.waterfall([
    dbConnect,
    seedUser,
    seedList,
    seedItems
  ], (err) => {
    mongoose.connection.close()
  });
});

gulp.task('sampleClear', () => {
  async.waterfall([
    dbConnect,
    clearItems,
    clearList,
    clearUser
  ], (err) => {
    mongoose.connection.close();
  });
});
