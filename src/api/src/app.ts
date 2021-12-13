import express = require('express');
import { useContainer, useExpressServer } from 'routing-controllers';
import Container from 'typedi';
import PetController from './controllers/PetController';
import swaggerLoader from './loaders/SwaggerLoader';

/**
 * Application Setup
 */
useContainer(Container);
const expressInstance = express();

const app = useExpressServer(expressInstance, {
  controllers: [PetController],
});

/**
 * Loaders
 */
swaggerLoader(app);

export default app;
