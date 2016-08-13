import express from 'express';
import Item from '../models/item';
import { respondForModel, respondForCollection,
 handleErr, handleSaveErr, saveSucc, handleDeleteErr, deleteSucc } from './responding';

let router = express.Router();

router.get('/', (req, res) => {
  Item.find().catch(err => handleErr(res, err)).then(items => respondForCollection(res, items));
});

router.get('/:id', (req, res) => {
  Item.findById(req.params.id)
    .catch(err => handleErr(res, err))
    .then(item => respondForModel(res, item));
});

// preliminary
router.post('/', (req, res) => {
  let item = new Item(req.body.item);
  item.save().catch(err => handleSaveErr(res, err, item)).then(saveSucc);
});

// preliminary
router.put('/:id', (req, res) => {
  Item.findByIdAndUpdate(req.params.id, req.body.item)
    .catch(err => handleSaveErr(res, err)).then(saveSucc);
});

// preliminary
router.delete('/:id', (req, res) => {
  Item.findByIdAndRemove(req.params.id)
    .catch(err => handleDeleteErr(res, err)).then(deleteSucc);
});

export default router;
