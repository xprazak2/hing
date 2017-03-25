import React from 'react';
import { Route } from 'react-router';
import Hing from './components/Hing';
import Home from './components/Home';
import ListsIndex from './pages/ListsIndex';
import ListsNew from './pages/ListsNew';

export default (
  <Route component={ Hing }>
    <Route path="/" component={ Home } />
    <Route path="/lists" component={ ListsIndex } />
    <Route path="/lists/new" component={ ListsNew } />
  </Route>
);
