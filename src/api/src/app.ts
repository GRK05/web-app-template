import express = require('express');
import { useExpressServer } from 'routing-controllers';
import PetController from './controllers/PetController';
import swaggerLoader from './loaders/SwaggerLoader';

/**
 * Application Setup
 */
const expressInstance = express();

const app = useExpressServer(expressInstance, {
  controllers: [PetController],
});

/**
 * Loaders
 */
swaggerLoader(app);

export default app;
