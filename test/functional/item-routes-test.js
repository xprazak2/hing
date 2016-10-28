import { hingTest,
         setup,
         teardown,
         callGetRoute,
         callDeleteRoute,
         callPostRoute,
         callPutRoute } from '../test-helper';
import Item from '../../src/models/item';
import List from '../../src/models/list';

setup();

const itemObj = { name: 'matches', amount: '30 pcs', location: 'bucket' };
const listObj = { name: 'simpleList' };

const createItem = (list) => {
  itemObj.listId = list.id;
  let item = new Item(itemObj);
  return item.save();
};

const before = () => {
  let list = new List(listObj);
  return list.save().then(listItem => createItem(listItem));
};

hingTest('should get item index', assert => {
  return callGetRoute('/items', 200, res => {
    let result = res.body.result;
      assert.equal(1, result.length);
      assert.equal(itemObj.name, result[0].name);
      assert.end();
  });
}, before);

hingTest('should get item by id', assert => {
  return Item.findOne({ name: itemObj.name }).then(item => {
    return callGetRoute('/items/' + item.id, 200, res => {
      let result = res.body.result;
        assert.equal(result.name, itemObj.name);
        assert.end();
    });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

hingTest('should delete item', assert => {
  return Item.findOne({ name: itemObj.name }).then(item => {
    return callDeleteRoute('/items/' + item.id, 200, res => {
      let result = res.body.result;
      assert.equal(result.name, itemObj.name);
      Item.findOne({ name: itemObj.name }).then(deletedItem => {
        assert.equal(deletedItem, null);
        assert.end();
      });
    });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

hingTest('should create item', assert => {
  return Item.find().then(items => {
    return List.find().then(lists => {
      let newItem = { name: 'gasoline',
                      amount: '5l',
                      location: 'basement',
                      expiry: new Date('2017-05-05'),
                      listId: lists[0].id };

      return callPostRoute('/items', 200, () => {
        return Item.find().then(afterItems => {
          assert.equal(items.length + 1, afterItems.length);
          assert.end();
        })
        .catch(err => {
          assert.end(err);
        });
      }, { item: newItem });
    })
    .catch(err => {
      assert.end(err);
    });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

hingTest('should update item', assert => {
  return Item.findOne({ name: 'matches' }).then(item => {
    let updateItem = { name: 'sardines' };
    return callPutRoute('/items/' + item.id, 200, res => {
      assert.equal(res.body.result.name, 'sardines');
      assert.end();
    }, { item: updateItem });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

teardown();
