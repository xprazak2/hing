import React from 'react';
import { Route } from 'react-router';
import Hing from './components/Hing';
import Home from './components/Home';
import Lists from './components/Lists';

export default (
  <Route component={ Hing }>
    <Route path="/" component={ Home } />
    <Route path="/lists" component={ Lists } />
  </Route>
);
