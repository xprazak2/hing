import React from 'react';
import { Route } from 'react-router';
import Hing from './hing';
import Home from './components/home';
import Lists from './components/lists';

export default (
  <Route component={ Hing }>
    <Route path="/" component={ Home } />
    <Route path="/lists" component={ Lists } />
  </Route>
)
