import { connect } from 'react-redux';
import { postList } from '../actions/lists-actions';
import { bindActionCreators } from 'redux';
import ListsNew from '../components/ListsNew';

let mapStateToProps = state => {
  console.log(state);
}

let mapDispatchToProps = dispatch => {
  return {
    postList: bindActionCreators(postList, dispatch)
  }
}

export default connect(null, mapDispatchToProps)(ListsNew);
