import dotenv from 'dotenv';
dotenv.config();
import { Sequelize, DataTypes, Dialect } from "sequelize";
import config from "../config/db.config";

const sequelize = new Sequelize(
    config.database || '',
    config.user || '',
    config.password || '',
    {
        host: config.host,
        port: Number(config.port),
        dialect: config.dialect as any as Dialect,
        dialectOptions: config.dialectOptions,
        timezone: config.timezone, // Set your timezone
        pool: config.pool,
        logging: console.log
    }
);

interface DbInterface {
    Categories?: any;
    Sequelize: typeof Sequelize;
    sequelize: Sequelize;
    Customers?: any;
    Packages?: any;
    Accounts?: any;
    Products?: any;
}

const db: DbInterface = {
    Sequelize,
    sequelize
};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

// Import model functions
import customerModel from "../models/customer.model";
import packageModel from "../models/package.model";
import accountModel from "../models/account.model";
import productModel from "../models/product.model";
import categoryModel from "../models/category.model"

// Initialize models
db.Customers = customerModel(sequelize);
db.Packages = packageModel(sequelize); 
db.Accounts = accountModel(sequelize);
db.Products = productModel(sequelize);
db.Categories = categoryModel(sequelize);

export default db;
