import { Request, Response } from 'express';
import packageService from '../services/package.service';

// GET Method (All)
export const getAllPackages = async (req: Request, res: Response) => {
    try {
        await packageService.get(req, res);
    } catch (error) {
        console.error("Error fetching packages: ", error);
        res.status(500).json({ message: "Error fetching packages" });
    }
};

export const packageController = {
    getAllPackages
}

export default packageController;