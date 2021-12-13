import express = require('express');
import { getMetadataArgsStorage } from 'routing-controllers';
import { routingControllersToSpec } from 'routing-controllers-openapi';
import * as swaggerUi from 'swagger-ui-express';
import { env } from '../env';

const swaggerLoader = (app: express.Application) => {
  if (env.swagger.enabled) {
    const storage = getMetadataArgsStorage();
    const spec = routingControllersToSpec(storage);

    spec.info = {
      title: env.app.name,
      version: env.app.version,
    };

    app.use(env.swagger.route, swaggerUi.serve, swaggerUi.setup(spec));
  }
};

export default swaggerLoader;
