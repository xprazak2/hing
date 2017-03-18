import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { Router, browserHistory } from 'react-router';
import routes from './routes';
import configureStore from './store';

const store = configureStore();

ReactDOM.render(<Provider store={ store }>
                  <Router history={ browserHistory }>
                    { routes }
                  </Router>
                </Provider>,
                document.getElementById('hing')
);
