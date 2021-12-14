import { Get, JsonController } from 'routing-controllers';
import { Service } from 'typedi';
import { Pet } from '../models/Pet';
import PetRepository from '../repositories/PetRepository';

@JsonController('/pets')
@Service()
class PetController {
  constructor(private petService: PetRepository) {}

  @Get()
  public find(): Promise<Pet[]> {
    return this.petService.getAll();
  }
}

export default PetController;
