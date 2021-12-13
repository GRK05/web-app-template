import { Get, JsonController } from 'routing-controllers';
import { Pet } from '../models/Pet';

@JsonController('/pets')
class PetController {
  @Get()
  public find(): Pet[] {
    const cat: Pet = {
      species: 'Cat',
    };

    const dog: Pet = {
      species: 'Dog',
    };

    return new Array<Pet>(cat, dog);
  }
}

export default PetController;
