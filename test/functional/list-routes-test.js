import { hingTest, setup, teardown, callGetRoute } from '../test-helper';
import List from '../../src/models/list';

setup();

const listObj = { name: 'sampleList' };

const before = () => {
  let list = new List(listObj);
  return list.save();
};

hingTest('should get list index', (assert) => {
  return callGetRoute('/lists', 200, (res) => {
     let result = res.body.result;
      assert.equal(1, result.length);
      assert.equal(listObj.name, result[0].name);
      assert.end();
  });
}, before);

hingTest('should get list by id', (assert) => {
  return List.findOne(listObj).then(list => {
    return callGetRoute('/lists/' + list.id, 200, (res) => {
       let result = res.body.result;
        assert.equal(result.name, listObj.name);
        assert.end();
    });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

teardown();
