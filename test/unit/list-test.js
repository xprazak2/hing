import { hingTest, setup, teardown } from '../test-helper';
import List from '../../src/models/list';

setup();

const before = () => {
  let list = new List({ name: 'sampleList' });
  return list.save();
};

hingTest('should save list', (assert) => {
  let list = new List({ name: 'testList' });
  return list.save().then((sth) => {
    assert.equal(sth.name, 'testList', 'list should be saved with given name');
    assert.end();
  }).catch(err => {
    assert.end(err);
  });
});

hingTest('should return list toView', (assert) => {
  return List.findOne({ name: 'sampleList' }).then(list => {
    let view = list.toView();
    assert.ok(view.name, 'list view should have name');
    assert.ok(view.id, 'list view should have id');
    assert.ok(view.createdAt, 'list view should have created time');
    assert.ok(view.updatedAt, 'list view should have updated time');
    assert.equal(Object.keys(view).length, 4, 'list view should have 4 attributes');
    assert.end();
  }).catch(err => assert.end(err));
}, before);

teardown();
