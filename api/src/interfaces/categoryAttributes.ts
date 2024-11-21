import { IntegerDataType } from "sequelize";

export interface CategoryAttributes {
    CategoryID: IntegerDataType;
    CategoryName: string;
    Date_Added?: Date;
    Date_Modified?: Date
}