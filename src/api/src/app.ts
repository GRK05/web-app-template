import { createExpressServer } from 'routing-controllers';
import { PetController } from './controllers/PetController';

const app = createExpressServer({
    controllers: [PetController],
});

export default app;