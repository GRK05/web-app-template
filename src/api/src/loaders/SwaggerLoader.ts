import { getMetadataArgsStorage } from "routing-controllers";
import { routingControllersToSpec } from "routing-controllers-openapi";
import { env } from "../env";
import * as swaggerUi from 'swagger-ui-express';
import app from "../app";

export const swaggerLoader = () => {
    if(env.swagger.enabled) {
        const storage = getMetadataArgsStorage()
        const spec = routingControllersToSpec(storage)

        spec.info = {
            title: env.app.name,
            version: env.app.version
        }
    
        app.use(
            env.swagger.route,
            swaggerUi.serve,
            swaggerUi.setup(spec)
        )
    }
}