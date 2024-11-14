import db from "../data/mssql";
import { Request, Response } from 'express';
import { QueryTypes } from 'sequelize';
import uploadFileService from "./uploadFile.service";

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
export const get = async (req: Request, res: Response) => {
    try {
        const customers = await db.Customers.findAll();
        res.status(200).json({
            message: "Retrieved all successfully.",
            data: customers
        });
    } catch (error) {
        console.error("Error fetching customers: ", error);
        res.status(500).json({ message: "Error fetching customers" });
    }
};

// GET Method (Details)
export const getDetails = async (req: Request, res: Response) => {
    try {
        const customer = await db.Customers.findByPk(req.query.id as string);
        if (customer) {
            res.status(200).json(customer);
        } else {
            res.status(404).json({ message: "Customer not found." });
        }
    } catch (error) {
        console.error("Error fetching customer: ", error);
        res.status(500).json({ message: "Error fetching customer" });
    }
};

// POST Method
export const post = async (req: Request, res: Response): Promise<any> => {
    try {
        const { key } = req.query;
        const { CustomerName, Gender, DateofBirth, PhoneNumber, PackID, StaffID, Note } = req.body;

        if (!CustomerName || !PhoneNumber || !PackID) {
            return res.status(400).json({ message: "Please provide all required fields." });
        }

        const existingCustomer = await db.Customers.findOne({
            where: { PhoneNumber }
        });
        if (existingCustomer) {
            return res.status(409).json({
                message: "Customer with this phone number already exists.",
                data: existingCustomer
            });
        }

        let formattedDateOfBirth = null;
        if (DateofBirth) {
            const parsedDate = new Date(DateofBirth);
            if (isNaN(parsedDate.getTime())) {
                return res.status(400).json({ message: "Invalid date format for DateofBirth." });
            }
            formattedDateOfBirth = parsedDate.toISOString();
        }

        const customerData: { [key: string]: unknown } = {
            CustomerName,
            Gender,
            DateofBirth: formattedDateOfBirth,
            PhoneNumber,
            PackID,
            StaffID,
            Note
        };  

        await db.sequelize.query(
            `INSERT INTO Customers (CustomerName, Gender, DateofBirth, PhoneNumber, PackID, StaffID, Note)
             VALUES (:CustomerName, :Gender, :DateofBirth, :PhoneNumber, :PackID, :StaffID, :Note)`,
            {
                replacements: customerData,
                type: QueryTypes.INSERT,
            }
        );

        const createdCustomer = await db.Customers.findOne({
            where: { PhoneNumber },
            order: [['Date_Added', 'DESC']]
        });

        res.status(201).json({
            message: "Customer created successfully.",
            data: createdCustomer,
            query: { key },
        });
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
export const put = async (req: Request, res: Response): Promise<any> => {
    try {
        const id = req.query.id as string;
        if (!id) {
            return res.status(400).json({ message: "Customer UID is required." });
        }

        let imageURL = '' as string;
        if (!req.files || Object.keys(req.files).length === 0) {
            //do nothing
        }
        else {
            let result = await uploadFileService(req.files.Image);
            imageURL = String(result.path);
        }
        const {
            CustomerName,
            Gender,
            DateofBirth,
            PhoneNumber,
            PackID,
            StaffID,
            Note
        } = req.body;

        const [originalCustomer] = await db.sequelize.query<CustomerData[]>(
            'SELECT * FROM Customers WHERE CustomerID = :id',
            {
                replacements: { id },
                type: QueryTypes.SELECT
            }
        );

        if (!originalCustomer) {
            return res.status(404).json({ message: "Customer not found." });
        }

        const [updated] = await db.sequelize.query(
            `UPDATE Customers 
                SET CustomerName = :CustomerName,
                    Gender = :Gender,
                    DateofBirth = CONVERT(DATE, :DateofBirth),
                    PhoneNumber = :PhoneNumber,
                    PackID = :PackID,
                    StaffID = :StaffID,
                    Startdate = GETDATE(),
                    Note = :Note,
                    Date_Modified = GETDATE(),
                    Image = :imageURL
                WHERE CustomerID = :CustomerID`,
            {
                replacements: {
                    CustomerName,
                    Gender,
                    DateofBirth: DateofBirth || null,
                    PhoneNumber,
                    PackID,
                    StaffID,
                    Note,
                    CustomerID: id,
                    imageURL
                },
                type: QueryTypes.UPDATE
            }
        );

        if (updated) {
            const updatedCustomer: CustomerData[] = await db.sequelize.query(
                'SELECT * FROM Customers WHERE CustomerID = :id',
                {
                    replacements: { id },
                    type: QueryTypes.SELECT
                }
            );

            // Adjust DateofBirth to remove timezone offset
            const adjustedDate = updatedCustomer[0].DateofBirth ? new Date(updatedCustomer[0].DateofBirth) : null;
            if (adjustedDate) {
                adjustedDate.setMinutes(adjustedDate.getMinutes() - adjustedDate.getTimezoneOffset());
                updatedCustomer[0].DateofBirth = adjustedDate.toISOString().split('T')[0]; // Format to "yyyy-MM-dd"
            }

            const changedFields: ChangedFields = { CustomerID: id };
            const ignoredFields = ['Startdate', 'Date_Added'];

            for (const key in updatedCustomer[0]) {
                if (key in originalCustomer && (updatedCustomer[0] as any)[key] !== (originalCustomer as any)[key] && !ignoredFields.includes(key)) {
                    changedFields[key] = updatedCustomer[0][key as keyof CustomerData];
                }
            }
            
            // Format DateofBirth to "yyyy-MM-dd" if it exists in the changed fields
            if ('DateofBirth' in changedFields && changedFields.DateofBirth) {
                changedFields.DateofBirth = new Date(changedFields.DateofBirth as string).toISOString().split("T")[0];
            }

            res.status(200).json({
                message: "Customer updated successfully.",
                updated: changedFields
            });
        } else {
            res.status(404).json({ message: "Customer not found." });
        }
    } catch (error) {
        console.error("Error updating customer:", error);
        res.status(500).json({ message: "Error updating customer" });
    }
};

// DELETE Method
export const remove = async (req: Request, res: Response): Promise<any> => {
    try {
        const id = req.query.id as string;

        if (!id) {
            return res.status(400).json({ message: "Customer ID is required." });
        }

        const existingCustomer = await db.Customers.findOne({
            where: { CustomerID: id }
        });

        if (!existingCustomer) {
            return res.status(404).json({ message: "Customer not found." });
        }

        await db.Customers.destroy({
            where: { CustomerID: id }
        });

        return res.status(200).json({
            message: "Customer deleted successfully.",
            data: {
                CustomerID: id,
                CustomerName: existingCustomer.CustomerName
            }
        });
    } catch (error) {
        console.error("Error deleting customer:", error);
        return res.status(500).json({ 
            message: "Error deleting customer",
            error: (error as Error).message 
        });
    }
};

export const uploadfile = async (req: any, res: any) => {
    try {
        if (!req.files || Object.keys(req.files).length === 0) {
            return res.status(400).json({ message: "No files were uploaded." });
        } else {
            const result = await uploadFileService(req.files.Image);
            console.log(">>> Check Result = ", result);
            if (result.status === 'success') {
                return res.status(200).json({
                    message: "File uploaded successfully.",
                    path: result.path
                });
            } else {
                return res.status(500).json({
                    message: "Error uploading file",
                    result: result
                })
            }
          
        }
    } catch (error) {
        console.log(">>> error upload file = ", error);
        return res.status(500).json({
            message: "Error uploading file",
            error: error
        })
    }
}

export const customerService = {
    get,
    getDetails,
    post,
    put,
    remove,
    uploadfile
}

export default customerService;
