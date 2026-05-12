import express from 'express';
import { db } from '../db.js';

export function createRouter(tableName) {
  const router = express.Router();

  router.get('/', async (req, res) => {
    try {
      const result = await db.query(`SELECT * FROM ${tableName}`);
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Ошибка сервера' });
    }
  });

  return router;
}
