import test from 'blue-tape';
import db from '../src/db';
import request from 'supertest-as-promised';
import app from './index-for-testing';

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

export function hingTest (description, fn, customBefore) {
  if (customBefore) {
    before(customBefore);
  }

  test(description, (assert) => {
    fn(assert).then(() => {
      after();
    });
  });
}

function callRoute (path, code, onRes, action, data) {
  return action.call(request(app), path)
    .send(data)
    .expect('Content-Type', /json/)
    .expect(code)
    .then(res => onRes(res))
    .catch(err => {
      console.log(err);
      console.log(err.response.text);
      after();
      assert.end(err);
      // assert not defined, this will exit the test suite with error
      // if assert.end() is not present, test suite hangs
      // assert is availabel inside onRes func, but it is skipped if any expect above fails
      // TODO: attach hingTest to obj so we can move route testing functions inside
      // and pass fn from line 45 into them, so we do not have to inside tests
    });
}

// find a way how to metaprogramm this
export function callGetRoute (path, code, onRes) {
  return callRoute(path, code, onRes, request(app).get);
}

export function callDeleteRoute (path, code, onRes) {
  return callRoute(path, code, onRes, request(app).delete);
}

export function callPostRoute (path, code, onRes, data) {
  return callRoute(path, code, onRes, request(app).post, data);
}

export function callPutRoute (path, code, onRes, data) {
  return callRoute(path, code, onRes, request(app).put, data);
}


