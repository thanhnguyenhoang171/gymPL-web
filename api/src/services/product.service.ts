import { QueryTypes } from 'sequelize';
import db from '../data/mssql';
import { Request, Response } from 'express';
import productController from '../controllers/productController';

// // Define interfaces for your data structure
// interface ProductData {
//     CategoryID: number;
//     ProductName: string;
//     Description: string | null;
//     SupplierID: number | null;
//     Quantity: number | null;
//     UnitPrice: number;
// }

// interface ChangedFields {
//     [key: string]: any;
//     ProductID: string | number;
// }

// GET Method (All)
export const get = async (req: Request, res: Response) => {
    try {
        const products = await db.Products.findAll();
        res.status(200).json({
            message: "Retrieved all successfully.",
            data: products
        });
    } catch (error) {
        console.error("Error fetching packages: ", error);
        res.status(500).json({ message: "Error fetching packages" });
    }
};

// GET Method (Details)
export const getDetails = async (req: Request, res: Response) => {
    try {
        const product = await db.Products.findByPk(req.query.id as string);
        if (product) {
            res.status(200).json(product);
        }
        else {
            res.status(404).json({
                message: "Product not found."
            });
        }
    } catch (error) {
        console.error("Error fetching product: ", error);
        res.status(500).json({
            message: "Error fetching product"
        });
    }
}
//POST Method 
export const post = async (req: Request, res: Response): Promise<any> => {
    try {
        const { key } = req.query;
        const { CategoryID, ProductName, Description, SupplierID, Quantity, UnitPrice } = req.body;


        if (!CategoryID || !ProductName || !UnitPrice) {
            return res.status(400).json({ message: "Missing required fields" });
        }
        const productData: { [key: string]: unknown } = {
            CategoryID,
            ProductName,
            Description,
            SupplierID,
            Quantity,
            UnitPrice,
        }

        await db.sequelize.query(
            `INSERT INTO Products (CategoryID, ProductName, Description, SupplierID, Quantity, UnitPrice)
                VALUES (:CategoryID, :ProductName, :Description, :SupplierID, :Quantity, :UnitPrice)`,
            {
                replacements: productData,
                type: QueryTypes.INSERT,
            }
        )

        const createdProduct = await db.Products.findOne({
            where: { ProductName },
            order: [['Date_Added', 'DESC']]

        });

        res.status(201).json({
            message: "Product created successfully.",
            data: createdProduct,
            query: { key },
        });
    } catch (error) {
        console.error("Error adding product: ", error);
        const typedError = error as Error;
        res.status(500).json({
            message: "Error adding product",
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
                message: "ProductID is required."
            });
        }
        // Check product exist
        const product = await db.Products.findOne({ where: { ProductID: id } });
        if (!product) {
            return res.status(404).json({
                message: "Product not found!"
            });
        }
        const result = await db.Products.destroy({ where: { ProductID: id } });
        return res.status(200).json({
            message: "Product deleted successfully.",
            data: {
                ProductID: id,
                ProductName: product.ProductName
            }
        });
    } catch (error) {
        console.error("Error deleting product: ", error);
        return res.status(500).json({
            message: "Error deleting customer",
            error: (error as Error).message
        })
    }
}

export const productService = {
    get, post, getDetails, remove
}

export default productService;