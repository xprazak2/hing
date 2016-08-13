export function respondForItem(res, item) {
  res.json({ result: item.toView() });
}

export function respondForCollection(res, collection) {
  res.json({ result: collection.map(item => item.toView()) });
}

export function handleError(res, err) {
  res.status(err.status || 500);
  res.json({ message: err });
}
