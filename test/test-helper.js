import test from 'blue-tape';
import db from '../src/db';

// do something before test
function before (fn) {
  test('before', (assert) => {
    fn().then(() => {
      assert.end();
    }).catch(err => assert.end(err));
  });
};

// drop db after test
const after = () => {
  db.clear();
};

// connect to db at the beginning of the test suite
export function setup (fn) {
  test('setup', (assert) => {
    db.connect().then(() => {
      if (fn) {
        fn().then(() => {
           assert.end();
        }).catch(err => {
          assert.end(err);
        });
      } else {
        assert.end();
      }
    }).catch(err => assert.end(err));
  });
}

export function teardown () {
  test('teardown', (assert) => {
    db.disconnect().then(() => {
      assert.end();
    }).catch(err => assert.end(err));
  });
}

export function hingTest(description, fn, customBefore) {
  if (customBefore) {
    before(customBefore);
  }

  test(description, (assert) => {
    fn(assert).then(() => {
      after();
    });
  });
}
