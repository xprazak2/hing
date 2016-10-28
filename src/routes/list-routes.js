import express from 'express';
import List from '../models/list';
import { respondForModel,
         respondForCollection,
         handleErr } from './responding';

let router = express.Router();

router.get('/', (req, res) => {
  List.find()
    .catch(err => handleErr(res, err))
    .then(lists => respondForCollection(res, lists));
});

router.get('/:id', (req, res) => {
  List.findById(req.params.id)
    .catch(err => handleErr(res, err))
    .then(list => respondForModel(res, list));
});

router.post('/', (req, res) => {
  let list = new List(req.body.list);
  list.save().catch(err => handleErr(res, err))
             .then(item => respondForModel(res, item));
});

router.put('/:id', (req, res) => {
  List.findByIdAndUpdate(req.params.id, req.body.list, { new: true })
    .catch(err => handleErr(res, err))
    .then(item => respondForModel(res, item));
});

router.delete('/:id', (req, res) => {
  List.findByIdAndRemove(req.params.id)
    .catch(err => handleErr(res, err))
    .then(deletedList => respondForModel(res, deletedList));
});

export default router;
