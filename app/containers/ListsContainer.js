import { connect } from 'react-redux';
import { getLists } from '../actions/lists-actions';
import { bindActionCreators } from 'redux';
import Lists from '../components/Lists';

let mapStateToProps = (state) => {
  return state;
}

let mapDispatchToProps = (dispatch) => {
  return {
      getLists: bindActionCreators(getLists, dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Lists);
