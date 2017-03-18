import { GET_LISTS } from '../actions/lists-actions';

const initialListsState = {
  loading: false,
  lists: [],
  errors: []
};

const listsReducer = (listsState = initialListsState, action) => {
  switch(action.type) {
    case GET_LISTS:
      return Object.assign({}, initialListsState, {
        loading: action.loading,
        lists: action.lists,
        errors: action.errors
      });
    default:
      return initialListsState;
  }
};

export default listsReducer;
