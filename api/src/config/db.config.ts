import { config as conf } from 'dotenv';
conf();
const config = {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    dialect: process.env.DB_DIALECT,
    dialectOptions: {
        options: {
            encrypt: true,
            trustServerCertificate: true,
            useUTC: false,
            dateFirst: 1,
            enableArithAbort: true
        },
        // Ensure proper date handling
        typeCast: function (field: any, next: any) {
            if (field.type === 'DATETIME') {
                return field.string();
            }
            return next();
        }
    },
    timezone: '+07:00', // Set your timezone
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
};

export default config;
