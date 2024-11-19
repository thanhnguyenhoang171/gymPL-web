import db from "../data/mssql";
import { query, Request, Response } from 'express';
import { QueryTypes } from 'sequelize';

// GET Method (get all categories)
export const getAll = async (req: Request, res: Response): Promise<any> => {
    try {
        const categories = await db.Categories.findAll();
        return res.status(200).json({
            message: "Retrieved all successfully.",
            data: categories
        })
    } catch (error) {
        console.error("Error fetching categories: ", error);
        return res.status(500).json({
            message: "Error fetching categories!"
        })
    }
}
// GET Method (get details)
export const getCategoryById = async (req: Request, res: Response): Promise<any> => {
    try {
        // id is required
        const { id } = req.query;
        if (!id) {
            return res.status(400).json({
                message: "Please provide a categoryID!"
            })
        }
        // check exist category
        const category = await db.Categories.findByPk(req.query.id as string);
        if (category) {
            return res.status(200).json({
                message: "Get category successfully",
                data: category
            })

        }
        else {
            return res.status(404).json({
                message: "Category not found!"
            })
        }
    } catch (error) {
        console.error("Error get category")
        res.status(500).json({
            message: "Error get category"
        })
    }
}
//POST Method
export const postCategory = async (req: Request, res: Response): Promise<any> => {
    try {
        const { CategoryName } = req.body;
        if (!CategoryName) {
            return res.status(400).json({
                message: "Please provide a category name!"
            })
        }
        const result = await db.Categories.create({ CategoryName });
        return res.status(201).json({
            message: "Add a category successfully!",
            data: result
        });
    } catch (error) {
        console.error("Error insert a category: ", error);
        return res.status(500).json({
            message: "Error insert new category",
        })
    }
}

// DELETE Method
export const remove = async (req: Request, res: Response): Promise<any> => {
    try {
        const id = req.query.id as string;
        if (!id) {
            return res.status(400).json({
                message: "Please provide a categoryID!"
            })
        }
        const category = await db.Categories.findOne({ where: { CategoryID: id } });
        if (!category) {
            return res.status(404).json({
                message: "Category not found!"
            })
        }
        const result = await db.Categories.destroy({ where: { CategoryID: id } })
        return res.status(200).json({
            message: "Remove a category successfully!",
            categoryName: category.CategoryName,
            result: result
        })
    } catch (error) {
        console.error("Error removing a category: ", error);
        return res.status(500).json({
            message: "Error removing a category!"
        })
    }
}
export const putCategory = async (req: Request, res: Response): Promise<any> => {
    try {
        const id = req.query.id as string;
        if (!id) {
            return res.status(400).json({
                message: "CategoryID is required"
            });
        }
        const category = await db.Categories.findOne({ where: { CategoryID: id } });
        if (!category) {
            return res.status(404).json({
                message: "Category not found!"
            });
        }
        const { CategoryName } = req.body;
        const result = await db.Categories.update({ CategoryName: CategoryName }, { where: { CategoryID: id } });
        return res.status(200).json({
            message: "Update a category successfully!",
            result: result
        })
    } catch (error) {
        console.error("Error updating category: ", error);
        return res.status(500).json({
            message:"Error updating category!"
        })
    }
}
export const categoryService = {
    getAll, getCategoryById, postCategory, remove, putCategory
}

export default categoryService;
