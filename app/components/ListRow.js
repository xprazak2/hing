import React, { Component } from 'react';

class ListRow extends Component {
  render() {
    return (
      <tr>
        <td> { this.props.list.name } </td>
        <td> { this.props.list.updatedAt } </td>
        <td>
          <button className="ink-button">Edit</button>
          <button className="ink-button">Destroy</button>
        </td>
      </tr>
    );
  }
}

export default ListRow;
