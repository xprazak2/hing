import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import createLogger from 'redux-logger';
import reducer from './reducers/reducer';
import { composeWithDevTools } from 'redux-devtools-extension';
import reduxPromise from 'redux-promise';


const configureStore = (initialState = {}) => {
  // TODO: logger only in dev env
  const middleware = [thunk, createLogger(), reduxPromise];
  const composer = composeWithDevTools || compose;

  const finalCreateStore = composer(applyMiddleware(...middleware))(createStore);
  return finalCreateStore(reducer, initialState);
}

export default configureStore;
