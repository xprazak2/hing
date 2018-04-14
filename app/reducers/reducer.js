import { combineReducers } from 'redux';
import listsReducer from './lists-reducer';
import { reducer as formReducer } from 'redux-form';

export default combineReducers({
  listsState: listsReducer,
  form: formReducer
});
