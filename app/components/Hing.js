import React, { Component } from 'react';
import Navbar from './Navbar';
import styles from '../../public/stylesheets/main.scss';

class Hing extends Component {
  render() {
    return (
      <div>
        <Navbar />
        <div className="ink-grid">
          { this.props.children }
        </div>
      </div>
    );
  }
}

export default Hing;
