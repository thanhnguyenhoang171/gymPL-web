import db from "./mssql";

const DbConnect = async () => {
    try {
        await db.sequelize.authenticate()
        console.log('Connection has been established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

export default DbConnect;