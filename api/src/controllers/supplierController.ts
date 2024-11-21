import { Request, Response } from 'express';
import supplierService from '../services/supplier.service';

// GET Method (All)
export const getAllSuppliers = async (req: Request, res: Response) => {
    try {
        await supplierService.get(req, res);
    } catch (error) {
        console.error("Error fetching suppliers: ", error);
        res.status(500).json({ message: "Error fetching suppliers" });
    }
};
// GET Method (Details)
export const getSupplierById = async (req: Request, res: Response) => {
    try {
        await supplierService.getDetails(req, res);
    } catch (error) {
        console.error("Error fetching supplier: ", error);
        res.status(500).json({
            message: "Error fetching supplier"
        });
    }
}
// POST Method
export const postSupplier = async (req: Request, res: Response): Promise<any> => {
    try {
        await supplierService.post(req, res);
    } catch (error) {
        console.error("Error crearting supplier", error);
        const typedError = error as Error;
        return res.status(500).json({
            message: "Error creating suppliers",
            detaills: typedError.message
        });

    }
}

export const deleteSupplier = async (req: Request, res: Response): Promise<any> => {
    try {
        const result = await supplierService.remove(req, res);
    } catch (error) {
        return res.status(500).json({
            message: "Error deleting supplier",
            error: (error as Error).message
        });
    }

}

export const updateSupplier = async (req: Request, res: Response): Promise<any> => {
    try {
        await supplierService.update(req, res);
    } catch (error) {
        console.error("Error updating supplier: ", error);
        res.status(500).json({
            message: "Error updating supplier"
        });
    }
}

export const supplierController = {
    getAllSuppliers, postSupplier, getSupplierById, deleteSupplier, updateSupplier
}

export default supplierController;