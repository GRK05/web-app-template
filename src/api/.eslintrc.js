module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  extends: ['airbnb-base', 'airbnb-typescript/base', 'eslint:recommended', 'plugin:@typescript-eslint/recommended'],
  env: {
    browser: true,
    jasmine: true,
    jest: true,
    node: true,
  },
  parserOptions: {
    project: './tsconfig.eslint.json',
    tsconfigRootDir: __dirname,
    sourceType: 'module',
  },
  rules: {
    'max-len': [
      'error',
      {
        code: 160,
        ignoreStrings: true,
      },
    ],
    '@typescript-eslint/no-unused-vars': ['error'],
    'class-methods-use-this': 'off',
  },
};
