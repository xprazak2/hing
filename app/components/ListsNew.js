import React, { Component } from 'react';

class ListsNew extends Component {
  render() {
    return (
      <form className="ink-form">
        <div className="all-33">
          <div className="control-group">
            <label htmlFor="required-name">Name</label>
            <div className="control">
              <input id="name" name="name" type="text" placeholder="New list name" />
            </div>
          </div>
          <button className="ink-button blue">Create</button>
          <button className="ink-button">Cancel</button>
        </div>
      </form>
    )
  }
}

export default ListsNew;
