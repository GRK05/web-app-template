import { Service } from 'typedi';
import { Pet } from '../models/Pet';
import AbstractFirestoreService from './AbstractFirestoreService';

@Service({ transient: true })
class PetService extends AbstractFirestoreService {
  constructor() {
    super('pets');
  }

  public async getAll(): Promise<Pet[]> {
    const query = await this.db.collection(this.collectionName).get();
    const pets = query.docs.map((x) => x.data() as Pet);

    return pets;
  }
}

export default PetService;
