import { Model, DataTypes, Sequelize } from 'sequelize';
import { SupplierAttributes } from '../interfaces/supplierAttributes';

interface SupplierInstance extends Model<SupplierAttributes>, SupplierAttributes { }

export default (sequelize: Sequelize) => {
    const Suppliers = sequelize.define<SupplierInstance>("Supplier", {
        SupplierID: {
            type: DataTypes.STRING(5),
            primaryKey: true,
            allowNull: false
        },
        CompanyName: {
            type: DataTypes.STRING(50),
            allowNull: false,
        },
        ContactName: {
            type: DataTypes.STRING(50),
            allowNull: true,
        },
        ContactPhone: {
            type: DataTypes.STRING(20),
            allowNull: true,
        },
        Address: {
            type: DataTypes.STRING(50),
            allowNull: true,
        },
        City: {
            type: DataTypes.STRING(50),
            allowNull: true,
        },
        Country: {
            type: DataTypes.STRING(50),
            allowNull: true,
        },
        Date_Added: {
            type: DataTypes.DATE,
            allowNull: true,
        },
        Date_Modified: {
            type: DataTypes.DATE,
            allowNull: true,
        },
    }, {
        tableName: "Supplier",
        timestamps: false,
    });
    return Suppliers;
};