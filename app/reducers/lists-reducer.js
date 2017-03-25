import { GET_LISTS } from '../actions/lists-actions';
import { POST_LIST } from '../actions/lists-actions';

const initialListsState = {
  loading: false,
  lists: [],
  errors: []
};

const listsReducer = (listsState = initialListsState, action) => {
  switch(action.type) {
    case GET_LISTS:
      return Object.assign({}, listsState, {
        loading: action.loading,
        lists: action.lists,
        errors: action.errors
      });
    case POST_LIST:
      return Object.assign({}, listsState, {
        loading: action.loading,
        errors: action.errors
      });
    default:
      return listsState;
  }
};

export default listsReducer;
