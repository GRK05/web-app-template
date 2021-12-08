import request = require('supertest');
import app from '../../src/app';

describe('Test PetController', () => {
    it('Request /pets should success response!', async () => {
        const result = await request(app).get('/pets').send();

        expect(result.status).toBe(200);
    });
});