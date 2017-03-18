import React, { Component } from 'react';
import ListRow from './ListRow';

class Lists extends Component {
  componentDidMount() {
    // console.log(this.props)
    this.props.fetchLists()
  }

  render() {
    return (
      <div className="column-group">
        <div >
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
