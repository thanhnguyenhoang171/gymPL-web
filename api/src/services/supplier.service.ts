import { QueryTypes } from 'sequelize';
import db from '../data/mssql';
import { Request, Response } from 'express';
import supplierController from '../controllers/supplierController';
import { promises } from 'dns';

// Use for Updating
// Define interfaces for your data structure
interface supplierData {
    CompanyName: string;
    ContactName: string | null;
    ContactPhone: string | null;
    Address: string | null;
    City: string | null;
    Country: string | null;
}

interface ChangedFields {
    [key: string]: any;
    SupplierID: string | number;
}

// GET Method (All)
export const get = async (req: Request, res: Response) => {
    try {
        const suppliers = await db.Suppliers.findAll();
        res.status(200).json({
            message: "Retrieved all successfully.",
            data: suppliers
        });
    } catch (error) {
        console.error("Error fetching suppliers: ", error);
        res.status(500).json({ message: "Error fetching suppliers" });
    }
};

// GET Method (Details)
export const getDetails = async (req: Request, res: Response) => {
    try {
        const supplier = await db.Suppliers.findByPk(req.query.id as string);
        if (supplier) {
            res.status(200).json(supplier);
        }
        else {
            res.status(404).json({
                message: "Supplier not found."
            });
        }
    } catch (error) {
        console.error("Error fetching supplier: ", error);
        res.status(500).json({
            message: "Error fetching supplier"
        });
    }
}
//POST Method 
export const post = async (req: Request, res: Response): Promise<any> => {
    try {
        const { key } = req.query;
        const { CompanyName, ContactName, ContactPhone
            , Address, City, Country } = req.body;


        if (!CompanyName) {
            return res.status(400).json({ message: "Missing required fields" });
        }
        const supplierData: { [key: string]: unknown } = {
            CompanyName,
            ContactName,
            ContactPhone,
            Address,
            City,
            Country,
        }

        await db.sequelize.query(
            `INSERT INTO supplier (CompanyName, ContactName, ContactPhone, Address, City, Country)
                VALUES (:CompanyName, :ContactName, :ContactPhone, :Address, :City, :Country)`,
            {
                replacements: supplierData,
                type: QueryTypes.INSERT,
            }
        )

        const createdsupplier = await db.Suppliers.findOne({
            where: { CompanyName },
            order: [['Date_Added', 'DESC']]

        });

        res.status(201).json({
            message: "Supplier created successfully.",
            data: createdsupplier,
            query: { key },
        });
    } catch (error) {
        console.error("Error adding supplier: ", error);
        const typedError = error as Error;
        res.status(500).json({
            message: "Error adding supplier",
            details: typedError.message
        });
    }
}

export const remove = async (req: Request, res: Response): Promise<any> => {
    try {
        const id = req.query.id as string;

        //Check blank id!
        if (!id) {
            return res.status(400).json({
                message: "SupplierID is required."
            });
        }
        // Check supplier exist
        const supplier = await db.Suppliers.findOne({ where: { supplierID: id } });
        if (!supplier) {
            return res.status(404).json({
                message: "Supplier not found!"
            });
        }
        const result = await db.Suppliers.destroy({ where: { supplierID: id } });
        return res.status(200).json({
            message: "Supplier deleted successfully.",
            data: {
                supplierID: id,
                CompanyName: supplier.CompanyName
            }
        });
    } catch (error) {
        console.error("Error deleting Supplier: ", error);
        return res.status(500).json({
            message: "Error deleting Supplier",
            error: (error as Error).message
        })
    }
}

// PUT Method - Update supplier
export const update = async (req: Request, res: Response): Promise<any> => {
    try {
        const id = req.query.id as string;
        if (!id) {
            return res.status(400).json({
                message: "Supplier UID is required."
            });
        }

        const {
            CompanyName,
            ContactName,
            ContactPhone,
            Address,
            City,
            Country
        } = req.body;

        if (!CompanyName) {
            return res.status(400).json({
                message: "CompanyName is required."
            });
        }

        const originalSupplier = await db.sequelize.query<supplierData>(
            `SELECT * FROM Supplier WHERE SupplierID = :id`,
            {
                replacements: { id },
                type: QueryTypes.SELECT
            }
        );

        if (!originalSupplier) {
            return res.status(404).json({ message: "Supplier not found." });
        }

        const updateData: Partial<supplierData> = {};
        const fieldsToCheck = {
            CompanyName,
            ContactName,
            ContactPhone,
            Address,
            City,
            Country
        };
        // Check data change and get it to update
        console.log("Check original supplier = ", originalSupplier[0])
        for (const [key, value] of Object.entries(fieldsToCheck)) {
            if (value !== undefined && value !== originalSupplier[0][key as keyof supplierData]) {
                updateData[key as keyof supplierData] = value;
            }
        }

        if (Object.keys(updateData).length === 0) {
            return res.status(200).json({
                message: "No changes detected. Supplier remains unchanged."
            });
        }

        const [updatedRows] = await db.sequelize.query(
            `UPDATE Supplier
             SET ${Object.keys(updateData).map(field => `${field} = :${field}`).join(', ')},
              Date_Modified = GETDATE() 
             WHERE SupplierID = :SupplierID`,
            {
                replacements: {
                    ...updateData,
                    SupplierID: id
                },
                type: QueryTypes.UPDATE
            }
        );

        if (!updatedRows) {
            return res.status(404).json({ message: "Supplier not found or not updated." });
        }

        return res.status(200).json({
            message: "Supplier updated successfully.",
            updatedFields: updateData
        });

    } catch (error) {
        console.error("Error updating Supplier:", error);
        return res.status(500).json({ message: "Error updating Supplier." });
    }
};





export const supplierService = {
    get, getDetails, post, remove, update

}

export default supplierService;