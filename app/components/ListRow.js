import React, { Component } from 'react';

class ListRow extends Component {
  render() {
    return (
      <tr>
        <td> { this.props.list.name } </td>
        <td> { this.props.list.updatedAt } </td>
        <td> Here will be an action </td>
      </tr>
    );
  }
}

export default ListRow;
