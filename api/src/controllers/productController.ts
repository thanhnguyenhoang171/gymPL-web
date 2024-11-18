import { Request, Response } from 'express';
import productService from '../services/product.service';

// GET Method (All)
export const getAllProducts = async (req: Request, res: Response) => {
    try {
        await productService.get(req, res);
    } catch (error) {
        console.error("Error fetching packages: ", error);
        res.status(500).json({ message: "Error fetching packages" });
    }
};
// GET Method (Details)
export const getProductById = async (req: Request, res: Response) => {
    try {
        await productService.getDetails(req, res);
    } catch (error) {
        console.error("Error fetching product: ", error);
        res.status(500).json({
            message: "Error fetching product"
        });
    }
}
// POST Method
export const postProduct = async (req: Request, res: Response): Promise<any> => {
    try {
        await productService.post(req, res);
    } catch (error) {
        console.error("Error crearting product", error);
        const typedError = error as Error;
        return res.status(500).json({
            message: "Error creating customer",
            detaills: typedError.message
        });

    }
}

export const deleteProduct = async (req: Request, res: Response): Promise<any> => {
    try {
        const result = await productService.remove(req, res);
    } catch (error) {
        return res.status(500).json({
            message: "Error deleting product",
            error: (error as Error).message
        });
    }

} 

export const updateProduct = async (req: Request, res: Response): Promise<any> => {
    try {
        await productService.update(req, res);
    } catch (error) {
        console.error("Error updating product: ", error);
        res.status(500).json({
            message: "Error updating customer"
        });
    }
}

export const productController = {
    getAllProducts, postProduct, getProductById, deleteProduct, updateProduct
}

export default productController;