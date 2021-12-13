import 'reflect-metadata';

import application from './app';

const PORT: string | number = process.env.PORT || 4000;

// eslint-disable-next-line no-console
application.listen(PORT, (): void => { console.log(`Server is listening on port ${PORT}`); });
