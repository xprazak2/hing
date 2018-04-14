import React from 'react';

export default ({ field, placeholder, meta: { touched, errro } }) =>
    <div>
      <input type="text" { ...field } placeholder={ placeholder } />
      { touched && error && <span>{ error }</span> }
    </div>

