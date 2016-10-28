import express from 'express';
import Item from '../models/item';
import { respondForModel,
         respondForCollection,
         handleErr } from './responding';

let router = express.Router();

router.get('/', (req, res) => {
  Item.find()
    .catch(err => handleErr(res, err))
    .then(items => respondForCollection(res, items));
});

router.get('/:id', (req, res) => {
  Item.findById(req.params.id)
    .catch(err => handleErr(res, err))
    .then(item => respondForModel(res, item));
});

router.post('/', (req, res) => {
  let item = new Item(req.body.item);
  item.save().catch(err => handleErr(res, err))
             .then(newItem => respondForModel(res, newItem));
});

router.put('/:id', (req, res) => {
  Item.findByIdAndUpdate(req.params.id, req.body.item, { new: true })
    .catch(err => handleErr(res, err))
    .then(item => respondForModel(res, item));
});

router.delete('/:id', (req, res) => {
  Item.findByIdAndRemove(req.params.id)
    .catch(err => handleErr(res, err))
    .then(deletedItem => respondForModel(res, deletedItem));
});

export default router;
