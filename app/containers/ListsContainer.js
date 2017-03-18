import { connect } from 'react-redux';
import { fetchLists } from '../actions/lists-actions';
import { bindActionCreators } from 'redux';
import Lists from '../components/Lists';

let mapStateToProps = (state) => {
  return state;
}

let mapDispatchToProps = (dispatch) => {
  return {
      fetchLists: bindActionCreators(fetchLists, dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Lists);
