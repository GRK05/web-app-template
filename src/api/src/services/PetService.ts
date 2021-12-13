import { Firestore } from '@google-cloud/firestore';
import { Service } from 'typedi';
import { env } from '../env';
import { Pet } from '../models/Pet';

@Service({ transient: true })
class PetService {
  private collectionName = 'pets';

  private db: Firestore;

  constructor() {
    if (env.firestore.useApplicationDefaultCredentials) {
      this.db = new Firestore({
        projectId: env.firestore.projectId,
      });
    } else {
      this.db = new Firestore({
        projectId: env.firestore.projectId,
        keyFilename: env.firestore.keyFilename,
      });
    }
  }

  public async getAll(): Promise<Pet[]> {
    const query = await this.db.collection(this.collectionName).get();
    const pets = query.docs.map((x) => x.data() as Pet);

    return pets;
  }
}

export default PetService;
