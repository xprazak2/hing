import axios from 'axios';

// TODO: do not hardcode url
const url = 'http://localhost:3000/api'

export const GET_LISTS = 'GET_LISTS';

const getLists = (data, errors, loading) => {
  const result = data.hasOwnProperty('result') ? data.result : [];
  return {
    type: GET_LISTS,
    lists: result,
    errors,
    loading
  };
};

export const fetchLists = () => {
  return (dispatch) => {
    dispatch(getLists([], [], true));

    console.log('fetching lists, this can take time');

    return axios.get(url + '/lists')
      .then(response => response.data)
      .then(json => dispatch(getLists(json, [], false)))
      .catch(json => dispatch(getLists([], json, false)));
  }
}
