import axios from 'axios';

// TODO: do not hardcode url
const url = 'http://localhost:3000/api'

export const GET_LISTS = 'GET_LISTS';
export const POST_LIST = 'POST_LIST';

const resultFrom = (data) => {
  return data.hasOwnProperty('result') ? data.result : [];
};

const getLists = (data, errors, loading) => {
  return {
    type: GET_LISTS,
    lists: resultFrom(data),
    errors,
    loading
  };
};

const postList = (errors, loading) => {
  return {
    type: POST_LIST,
    errors,
    loading
  }
};

export const fetchLists = () => {
  return (dispatch) => {
    dispatch(getLists([], [], true));

    console.log('fetching lists, this can take time');

    return axios.get(`${url}/lists`)
      .then(response => response.data)
      .then(json => dispatch(getLists(json, [], false)))
      .catch(json => dispatch(getLists([], json, false)));
  }
}

export const createList = () => {
  return (dispatch) => {
    dispatch(postLists([], true));

    return axios.post(`${url}/lists`)
      .then(response => console.log(response))
      .then(json => dispatch(postLists([], false)))
      .catch(json => dispatch(postLists(json, false)));
  }
}
