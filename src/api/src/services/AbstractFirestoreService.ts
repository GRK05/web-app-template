import { Firestore } from '@google-cloud/firestore';
import { env } from '../env';

abstract class AbstractFirestoreService {
  public collectionName: string;

  public db: Firestore;

  constructor(collectionName: string) {
    this.collectionName = collectionName;

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
}

export default AbstractFirestoreService;
