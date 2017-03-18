import React, { Component } from 'react';
import { Link } from 'react-router';

class Navbar extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <nav className="ink-navigation">
        <ul className="menu horizontal blue">
            <li><Link to="/">Home</Link></li>
            <li><Link to="/lists" activeClassName="active">Lists</Link></li>
        </ul>
    </nav>
    )
  }
}

export default Navbar;
