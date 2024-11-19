import { Request, Response } from 'express';
import categoryService from '../services/category.service';


export const getAllCategories = async(req: Request, res: Response): Promise<any> => {
    try {
        const categories = await categoryService.getAll(req, res);
    } catch (error) {
        console.error("Error get all categories: ", error);
        return res.status(500).json({
            message: "Error get all categories"
        });
    }
}
export const getDetailCategory = async (req: Request, res: Response): Promise<any> => {
    try {
        const category = await categoryService.getCategoryById(req, res);
    } catch (error) {
        console.error("Error get a category: ", error);
        return res.status(500).json({
            message: "Error get a category"
        });
    }
}

export const addCategory = async(req: Request, res: Response):Promise<any> => {
    try {
        await categoryService.postCategory(req, res);
    } catch (error) {
        console.error("Error adding new category: ", error);
        return res.status(500).json({
            message: "Error insert new category!",
        });
    }
}

export const deleteCategory = async (req: Request, res: Response): Promise<any> => {
    try {
        await categoryService.remove(req, res);
    } catch (error) {
        console.error("Error deleting a category: ", error);
        return res.status(500).json({
            message: "Error deleting a category"
        })
    }
}

export const updateCategory = async (req: Request, res: Response): Promise<any> => {
    try {
        await categoryService.putCategory(req, res);
    } catch (error) {
        console.error("Error updating a category: ", error);
        return res.status(500).json({
            message: "Error updating a category"
        })
    }
}

export const categoryController = {
    getAllCategories,getDetailCategory, addCategory, deleteCategory, updateCategory
}

export default categoryController;