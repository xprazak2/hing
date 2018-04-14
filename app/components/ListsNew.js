import React, { Component } from 'react';
import { Link } from 'react-router';
import { Field, reduxForm } from 'redux-form';
import InputField from './InputField';

class ListsNew extends Component {
  render() {
    const { error, postList } = this.props;
    console.log(this.props);
    return (
      <form className="ink-form" onSubmit={ postList }>
        <div className="all-33">
          <div className="control-group required">
            <label htmlFor="name">Name</label>
            <div className="control">
              <Field name="name" type="text" component={ InputField } placeholder="Name"/>
            </div>
          </div>
          { error && <strong>{ error }</strong> }
          <button className="ink-button blue">Submit</button>
          <button className="ink-button"><Link to="/lists">Cancel</Link></button>
        </div>
      </form>
    )
  }
}

ListsNew = reduxForm({ form: 'listsNew' })(ListsNew);

export default ListsNew;
