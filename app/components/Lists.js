import React, { Component } from 'react';
import { connect } from 'react-redux';
import { fetchLists } from '../actions/lists-actions';
import { bindActionCreators } from 'redux'

class Lists extends Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchLists()
  }

  render() {
    return (
      <div className="column-group">
        <div className="all-100 push-center">
          <table className="ink-table alternating">
            <thead>
              <tr>
                <th className="align-left">Name</th>
                <th className="align-left">Created At</th>
              </tr>
            </thead>
            <tbody>
            { this.props.listsState.lists.map( list => {
                return (
                  <tr>
                    <td> { list.name } </td>
                    <td> { list.updatedAt } </td>
                  </tr>
                );
              })
            }
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}
