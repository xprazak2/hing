import { connect } from 'react-redux';
import { createList } from '../actions/lists-actions';
import { bindActionCreators } from 'redux';
import ListsNew from '../components/ListsNew';

let mapStateToProps = state => {
  console.log(state);
}

let mapDispatchToProps = dispatch => {
  return {
    createList: bindActionCreators(createList, dispatch)
  }
}

export default connect(null, mapDispatchToProps)(ListsNew);
