import express from 'express';
import cors from 'cors';
import { db } from './db.js';

import cpuRouter from './routes/cpus.js';
import gpuRouter from './routes/gpus.js';
import coolerRouter from './routes/coolers.js';
import ramRouter from './routes/rams.js';
import storageRouter from './routes/storages.js';
import psuRouter from './routes/psus.js';
import motherboardRouter from './routes/motherboards.js';
import caseRouter from './routes/cases.js';

const app = express();
app.use(cors());
app.use(express.json());

app.get('/api/test', (req, res) => {
  res.json({ message: 'Backend работает!' });
});

app.use('/api/cpus', cpuRouter);
app.use('/api/gpus', gpuRouter);
app.use('/api/coolers', coolerRouter);
app.use('/api/cases', caseRouter);
app.use('/api/motherboards', motherboardRouter);
app.use('/api/psus', psuRouter);
app.use('/api/rams', ramRouter);
app.use('/api/storages', storageRouter);
console.log('Registered routes:');
app._router.stack.forEach(r => { if (r.route && r.route.path) console.log(Object.keys(r.route.methods).join(','), r.route.path); });

const server = app.listen(3001, "0.0.0.0", () => 
  console.log('SERVER STARTED ON PORT 3001')
);

process.on('SIGTERM', () => {
  server.close(() => process.exit(0));
});
