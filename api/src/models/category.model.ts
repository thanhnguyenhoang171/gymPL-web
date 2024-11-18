import { Model, DataTypes, Sequelize } from 'sequelize';
import { CategoryAttributes } from '../interfaces/categoryAttributes';

interface CategoriesInstance extends Model<CategoryAttributes>, CategoryAttributes {}

export default (sequelize: Sequelize) => {
  const Categories = sequelize.define<CategoriesInstance>("Categories", {
    CategoryID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: true // Auto generate by trigger in SQL Server
    },
    CategoryName: {
      type: DataTypes.STRING(20),
      allowNull: true,
    }
  }, {
    tableName: "Categories",
    timestamps: false,
  });

  return Categories;
};