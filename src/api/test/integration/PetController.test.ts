import request = require('supertest');
import application from '../../src/app';

describe('Test PetController', () => {
  it('Request /pets should success response!', async () => {
    const result = await request(application).get('/pets').send();

    expect(result.status).toBe(200);
  });
});
