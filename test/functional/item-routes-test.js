import { hingTest, setup, teardown, callGetRoute } from '../test-helper';
import Item from '../../src/models/item';
import List from '../../src/models/list';

setup();

const itemObj = { name: 'matches', amount: '30 pcs', location: 'bucket' };
const listObj = { name: 'sampleList' };

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

teardown();
