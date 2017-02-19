import React, { Component } from 'react'

class Navbar extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <nav className="ink-navigation">
        <ul className="menu horizontal blue">
            <li><a href="#">Home</a></li>
            <li><a href="#">Lists</a></li>
        </ul>
    </nav>
    )
  }
}

export default Navbar;
