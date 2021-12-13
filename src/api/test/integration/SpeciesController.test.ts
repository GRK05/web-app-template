import request = require('supertest');
import application from '../../src/app';

describe('Test SpeciesController', () => {
  it('Request /species should success response!', async () => {
    const result = await request(application).get('/species').send();

    expect(result.status).toBe(200);
  });
});
