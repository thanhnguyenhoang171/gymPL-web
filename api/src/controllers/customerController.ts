import { Request, Response } from 'express';
import customerService from "../services/customer.service";

// Define interfaces for your data structure
interface CustomerData {
    CustomerName: string;
    Gender: string | null;
    DateofBirth: string | null;
    PhoneNumber: string;
    PackID: number;
    StaffID?: number | null;
    Note?: string | null;
}

interface ChangedFields {
    [key: string]: any;
    CustomerID: string | number;
}

// GET Method (All)
export const getAllCustomers = async (req: Request, res: Response) => {
    try {
        await customerService.get(req, res);
    } catch (error) {
        console.error("Error fetching customers: ", error);
        res.status(500).json({ message: "Error fetching customers" });
    }
};

// GET Method (Details)
export const getCustomerById = async (req: Request, res: Response) => {
    try {
        await customerService.getDetails(req, res);
    } catch (error) {
        console.error("Error fetching customer: ", error);
        res.status(500).json({ message: "Error fetching customer" });
    }
};

// POST Method
export const addCustomer = async (req: Request, res: Response): Promise<any> => {
    try {
        await customerService.post(req, res);
    } catch (error) {
        console.error("Error creating customer: ", error);
        const typedError = error as Error;
        return res.status(500).json({
            message: "Error creating customer",
            details: typedError.message
        });
    }
}

// PUT Method
export const updateCustomer = async (req: Request, res: Response): Promise<any> => {
    try {
        await customerService.put(req, res);
    } catch (error) {
        console.error("Error updating customer:", error);
        res.status(500).json({ message: "Error updating customer" });
    }
};

// DELETE Method
export const deleteCustomer = async (req: Request, res: Response): Promise<any> => {
    try {
        await customerService.remove(req, res);
    } catch (error) {
        console.error("Error deleting customer:", error);
        return res.status(500).json({
            message: "Error deleting customer",
            error: (error as Error).message
        });
    }
};

export const uploadFileCustomer = async (req: any, res: any): Promise<any> => {
    try {
        await customerService.uploadfile(req, res);
    } catch (error) {
        console.error("Error uploading file: ", error);
        res.status(500).json({ message: "Error uploading file" });
    }
}
export const getFileCustomer = async (req: any, res: any): Promise<any> => {
    try {
        await customerService.uploadfile(req, res);
    } catch (error) {
        console.error("Error uploading file: ", error);
        res.status(500).json({ message: "Error uploading file" });
    }
}
export const customerController = {
    getAllCustomers,
    getCustomerById,
    addCustomer,
    updateCustomer,
    deleteCustomer,
    uploadFileCustomer
}

export default customerController;
