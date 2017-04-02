import React from 'react';
import { Input } from 'valuelink/tags';

const TextInput = (props) => {
  const { label, ...rest } = props;
  const required = rest.required ? 'required' : '',
        errors = [rest.valueLink.error, rest.errorLink.value].filter(item => item).join(', '),
        originalValue = rest.valueLink.value;
  const validation = errors ? 'validation error' : '';
  delete rest.errorLink
  console.log(errors)
  console.log(validation)
  return (
    <div className="control-group { required } { validation }">
      <label htmlFor="{ label.downcase() }">{ label }</label>
      <div className="control">
        <Input { ...props } />
      </div>
      <p className="tip">{ !rest.valueLink.value || errors }</p>
    </div>
  )
}

export default TextInput;
