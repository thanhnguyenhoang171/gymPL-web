import { Model, DataTypes, Sequelize } from 'sequelize';
import { PackageAttributes } from '../interfaces/packageAttributes';

interface PackageInstance extends Model<PackageAttributes>, PackageAttributes {}

export default (sequelize: Sequelize) => {
  const Package = sequelize.define<PackageInstance>("Package", {
    PackID: {
      type: DataTypes.STRING(3),
      primaryKey: true,
      allowNull: true // Auto generate by trigger in SQL Server
    },
    PackName: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    PackPrice: {
      type: DataTypes.DECIMAL(12,0),
      allowNull: true,
    },
    DurationDays: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    PackType: {
      type: DataTypes.STRING(20),
      allowNull: true,
    }
  }, {
    tableName: "Package",
    timestamps: false,
  });

  return Package;
};