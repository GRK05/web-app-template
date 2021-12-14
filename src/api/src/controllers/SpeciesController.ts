import { Get, JsonController } from 'routing-controllers';
import { Service } from 'typedi';
import { Species } from '../models/Species';

@JsonController('/species')
@Service()
class SpeciesController {
  @Get()
  public find(): Species[] {
    const cat: Species = {
      name: 'Cat',
    };

    const dog: Species = {
      name: 'Dog',
    };

    return new Array<Species>(cat, dog);
  }
}

export default SpeciesController;
