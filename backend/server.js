import express from 'express';
import cors from 'cors';
import { db } from './db.js';
import cpuRouter from './routes/cpus.js';

const app = express();
app.use(cors());
app.use(express.json());

app.get('/api/test', (req, res) => {
  res.json({ message: 'Backend работает!' });
});

app.use('/api/cpus', cpuRouter);

app.listen(3001, () => console.log('Backend запущен на порту 3001'));
