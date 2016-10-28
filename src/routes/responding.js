// turn keys nto model names instead of result?
export function respondForModel(res, instance) {
  res.json({ result: instance.toView() });
}

export function respondForCollection(res, collection) {
  res.json({ result: collection.map(instance => instance.toView()) });
}

export function handleErr(res, err) {
  res.status(err.status || 500);
  res.json({ message: err });
}
