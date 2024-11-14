import { Model, DataTypes, Sequelize } from 'sequelize';
import { CustomerAttributes } from '../interfaces/customerAttributes';

interface CustomerInstance extends Model<CustomerAttributes>, CustomerAttributes {}

export default (sequelize: Sequelize) => {
  const Customer = sequelize.define<CustomerInstance>("Customer", {
    CustomerID: {
      type: DataTypes.STRING(4),
      primaryKey: true,
      allowNull: true,
    },
    CustomerName: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    Gender: {
      type: DataTypes.STRING(10),
      allowNull: true,
    },
    DateofBirth: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    PhoneNumber: {
      type: DataTypes.STRING(20),
      allowNull: true,
    },
    PackID: {
      type: DataTypes.STRING(3),
      allowNull: true,
      references: {
        model: 'Package',
        key: 'PackID',
      }
    },
    StaffID: {
      type: DataTypes.STRING(4),
      allowNull: true,
      references: {
        model: 'Staff',
        key: 'StaffID',
      }
    },
    Startdate: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    DateRegister: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    Note: {
      type: DataTypes.TEXT,
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
    Image: {
      type: DataTypes.STRING(255),
      allowNull: true,
    }
  }, {
    tableName: "Customers",
    timestamps: false,
  });

  (Customer as any).associate = (models: any) => {
    (Customer as any).belongsTo(models.Staff, { 
      foreignKey: 'StaffID' 
    });
    (Customer as any).belongsTo(models.Package, { 
      foreignKey: 'PackID' 
    });
  }

  return Customer;
};
