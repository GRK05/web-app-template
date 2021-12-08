import { Get, JsonController } from 'routing-controllers';
import { Pet } from '../models/Pet';

@JsonController('/pets')
export class PetController {

    @Get()
    public find(): Pet[] {
        const pet: Pet = {
            species: 'Cat'
        }

        return new Array<Pet>(pet);
    }
}