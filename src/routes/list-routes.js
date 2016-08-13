import express from 'express';
import List from '../models/list';
import { respondForModel, respondForCollection, handleError } from './responding';

let router = express.Router();

router.get('/', (req, res) => {
  List.find().catch(err => handleError(res, err)).then(lists => respondForCollection(res, lists));
});

router.get('/:id', (req, res) => {
  List.findById(req.params.id)
    .catch(err => handleError(res, err))
    .then(list => respondForModel(res, list));
});

export default router;
