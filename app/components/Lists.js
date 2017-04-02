import React, { Component } from 'react';
import ListRow from './ListRow';
import { Link } from 'react-router';

class Lists extends Component {
  componentDidMount() {
    this.props.getLists()
  }

  render() {
    return (
      <div>
        <div className="column-group">
          <div className="top-space">
            <button className="ink-button push-right"><Link to="/lists/new">New</Link></button>
          </div>
        </div>
        <div className="column-group">
          <table className="ink-table alternating">
            <thead>
              <tr>
                <th className="align-left">Name</th>
                <th className="align-left">Created At</th>
                <th className="align-left">Actions</th>
              </tr>
            </thead>
            <tbody>
            { this.props.listsState.lists.map( list => {
                return <ListRow key={ list.id } list={ list } />
              })
            }
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

export default Lists;
