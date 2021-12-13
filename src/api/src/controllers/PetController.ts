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
  }
}

export default PetController;
