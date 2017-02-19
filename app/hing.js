import React, { Component } from 'react';
import Navbar from './navbar';
// import styles from '../public/stylesheets/main.scss';

class Hing extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <Navbar />
        <div>
          Hello from Humans!
        </div>
      </div>
    );
  }
}

export default Hing;
