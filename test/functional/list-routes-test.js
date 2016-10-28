import { hingTest,
         setup,
         teardown,
         callGetRoute,
         callDeleteRoute,
         callPostRoute,
         callPutRoute } from '../test-helper';
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
      console.log(result)
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

hingTest('should delete list', assert => {
  return List.findOne({ name: listObj.name }).then(list => {
    return callDeleteRoute('/lists/' + list.id, 200, res => {
      let result = res.body.result;
      assert.equal(result.name, listObj.name);
      List.findOne({ name: listObj.name }).then(deletedList => {
        assert.equal(deletedList, null);
        assert.end();
      });
    });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

hingTest('should update list', assert => {
  return List.findOne({ name: 'sampleList' }).then(list => {
    let updateList = { name: 'updatedList' };
    return callPutRoute('/lists/' + list.id, 200, res => {
      assert.equal(res.body.result.name, 'updatedList');
      assert.end();
    }, { list: updateList });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

hingTest('should create list', assert => {
  return List.find().then(lists => {
    let newList = { name: 'secondList' };
    return callPostRoute('/lists', 200, () => {
      return List.find().then(updatedLists => {
        assert.equal(lists.length + 1, updatedLists.length);
        assert.end();
      })
      .catch(err => {
        assert.end(err);
      });
    }, { list: newList });
  })
  .catch(err => {
    assert.end(err);
  });
}, before);

teardown();
