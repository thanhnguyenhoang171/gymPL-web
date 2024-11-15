import { Model, DataTypes, Sequelize } from 'sequelize';
import { ProductAttributes } from '../interfaces/productAttributes';

interface ProductInstance extends Model<ProductAttributes>, ProductAttributes { }

export default (sequelize: Sequelize) => {
    const Products = sequelize.define<ProductInstance>("Products", {
        ProductID: {
            type: DataTypes.STRING(5),
            primaryKey: true,
            allowNull: false
        },
        CategoryID: {
            type: DataTypes.INTEGER,
            allowNull: false,
            references: {
                model: 'Categories',
                key: 'PackID',
            }
        },
        ProductName: {
            type: DataTypes.STRING(50),
            allowNull: false,
        },
        Description: {
            type: DataTypes.TEXT,
            allowNull: true,
        },
        SupplierID: {
            type: DataTypes.STRING(5),
            allowNull: true,
            references: {
                model: 'Supplier',
                key: 'SupplierID',
            }
        },
        Quantity: {
            type: DataTypes.INTEGER,
            allowNull: true,
        },
        UnitPrice: {
            type: DataTypes.DECIMAL(18, 0),
            allowNull: false,
        },
        Date_Added: {
            type: DataTypes.DATE,
            allowNull: true,
        },
        Date_Modified: {
            type: DataTypes.DATE,
            allowNull: true,
        }
    }, {
        tableName: "Products",
        timestamps: false,
    });
    (Products as any).associate = (models: any) => {
        (Products as any).belongsTo(models.Categories, {
            foreignKey: 'CategoryID'
        });
        (Products as any).belongsTo(models.Supplier, {
            foreignKey: 'SupplierID'
        });
    }
    return Products;
};