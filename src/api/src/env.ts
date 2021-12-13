import * as dotenv from 'dotenv';
import * as path from 'path';

/**
 * Load .env file
 */
dotenv.config({ path: path.join(process.cwd(), `.env${((process.env.NODE_ENV === 'test') ? '.tests' : '')}`) });

export function getEnvironmentVariable(key: string): string {
  if (typeof process.env[key] === 'undefined') {
    throw new Error(`Environment variable ${key} is not set.`);
  }

  return process.env[key] as string;
}

export function toBool(value: string): boolean {
  return value === 'true';
}

/**
 * Environment variables
 */
export const env = {
  node: process.env.NODE_ENV || 'development',
  app: {
    name: getEnvironmentVariable('APP_NAME'),
    version: getEnvironmentVariable('APP_VERSION'),
  },
  firestore: {
    projectId: getEnvironmentVariable('PROJECT_ID'),
    useApplicationDefaultCredentials: toBool(getEnvironmentVariable('USE_APPLICATION_DEFAULT_CREDENTIALS')),
    keyFilename: getEnvironmentVariable('KEY_FILENAME'),
  },
  swagger: {
    enabled: toBool(getEnvironmentVariable('SWAGGER_ENABLED')),
    route: getEnvironmentVariable('SWAGGER_ROUTE'),
  },
};
