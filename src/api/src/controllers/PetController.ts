import { Get, JsonController } from 'routing-controllers';
import { Service } from 'typedi';
import { Pet } from '../models/Pet';
import PetService from '../services/PetService';

@JsonController('/pets')
@Service()
class PetController {
  constructor(private petService: PetService) {}

  @Get()
  public find(): Promise<Pet[]> {
    return this.petService.getAll();

    // const cat: Pet = {
    //   species: 'Cat',
    // };

    // const dog: Pet = {
    //   species: 'Dog',
    // };

    // return new Array<Pet>(cat, dog);
  }
}

export default PetController;
