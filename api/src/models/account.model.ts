import bcrypt from 'bcryptjs';
import { Model, DataTypes, Sequelize } from 'sequelize';
import { AccountAttributes } from '../interfaces/accountAttributes';

interface AccountInstance extends Model<AccountAttributes>, AccountAttributes {
  validPassword(password: string): Promise<boolean>;
}

export default (sequelize: Sequelize) => {
  const Account = sequelize.define<AccountInstance>("Account", {
    AccountID: {
      type: DataTypes.STRING(4),
      primaryKey: true,
      allowNull: true,
    },
    FullName: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    UserName: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    Password: {
      type: DataTypes.STRING(60),
      unique: true,
      allowNull: true,
    },
    Email: {
      type: DataTypes.STRING(50),
      allowNull: true,
      unique: true,
      validate: { isEmail: true },
    },
    PhoneNumber: {
      type: DataTypes.STRING(20),
      allowNull: true,
      validate: {
        isNumeric: true,
        len: [10, 12],
      }
    },
    Status: {
      type: DataTypes.STRING(20),
      allowNull: true,
    },
    CreatedDate: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    LastLogin: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    RoleId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Roles',
        key: 'RoleId',
      }
    },
  }, {
    tableName: "Account",
    timestamps: false,
    hooks: {
      beforeCreate: async (account: AccountInstance) => {
        if (account.Password) {
          account.Password = await bcrypt.hash(account.Password, 10) as string;
        }
      },
      beforeUpdate: async (account: AccountInstance) => {
        if (account.changed("Password") && account.Password) {
          account.Password = await bcrypt.hash(account.Password, 10) as string;
        }
      }
    }
  });

  (Account as any).associate = (models: any) => {
    Account.belongsTo(models.Role, {
      foreignKey: 'RoleId',
      as: 'Role',
    });
  };

  (Account.prototype as any).validPassword = async function(password: string): Promise<boolean> {
    if (!this.Password) return false;
    return await bcrypt.compare(password, this.Password);
  };

  return Account;
};