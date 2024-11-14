import db from '../data/mssql';
import { Request, Response } from 'express';

// GET Method (All)
export const get = async (req: Request, res: Response) => {
    try {
        const packages = await db.Packages.findAll();
        res.status(200).json({
            message: "Retrieved all successfully.",
            data: packages
        });
    } catch (error) {
        console.error("Error fetching packages: ", error);
        res.status(500).json({ message: "Error fetching packages" });
    }
};

export const packageService = {
    get
}

export default packageService;