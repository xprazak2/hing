import { hingTest, setup, teardown } from '../test-helper';
import Item from '../../src/models/item';
import List from '../../src/models/list';

setup();

const createItem = (list) => {
  let item = new Item({ name: 'matches', amount: '30 pcs', location: 'bucket', listId: list.id });
  return item.save();
};

const before = () => {
  let list = new List({ name: 'sampleList' });
  return list.save().then(list => createItem(list));
};

hingTest('should not save item', (assert) => {
  let item = new Item();
  return item.save().catch(err => {
    assert.ok(err.errors['name']);
    assert.end();
  });
});

hingTest('should return item toView', (assert) => {
  return Item.findOne({ name: 'matches' }).then(item => {
    let view = item.toView();
    assert.equal(view.amount, '30 pcs', 'should have amount in view');
    assert.equal(Object.keys(view).length, 8, 'should have 8 attrs in view');
    assert.end();
  }).catch(err => assert.end(err));
}, before);

teardown();
