export function modelToView(model, attrs) {
  return attrs.reduce((memo, attr) => {
    memo[attr] = model[attr];
    return memo;
  }, {});
}
