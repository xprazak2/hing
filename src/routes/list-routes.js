import express from 'express';
import List from '../models/list';
import { respondForItem, respondForCollection, handleError } from './responding';

let router = express.Router();

router.get('/', (req, res) => {
  List.find().catch(handleError).then(lists => respondForCollection(res, lists));
});

router.get('/:id', (req, res) => {
  List.findById(req.params['id'])
    .catch(handleError)
    .then(list => respondForItem(res, list));
});

export default router;
