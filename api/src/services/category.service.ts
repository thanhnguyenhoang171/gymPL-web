import db from "../data/mssql";
import { query, Request, Response } from 'express';
import { QueryTypes } from 'sequelize';

interface CategoriesData {
    CategoryName: string;
}

interface ChangedFields {
    [key: string]: { dataUpdated: any };
}

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
                message: "Please provide a category name!",
            });
        }

        const result = await db.sequelize.query(
            `INSERT INTO Categories (CategoryName) VALUES (:CategoryName)`,
            {
                replacements: { CategoryName },
                type: QueryTypes.INSERT,
            }
        );
        const createdCategory = await db.Categories.findOne({
            where: { CategoryName },
            order: [['Date_Added', 'DESC']],
        });
        return res.status(201).json({
            message: "Add a category successfully!",
            data: createdCategory,
        });
    } catch (error) {
        console.error("Error insert a category: ", error);
        return res.status(500).json({
            message: "Error inserting new category",
        });
    }
};


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
            return res.status(400).json({ message: 'Category UID is required.' });
        }

        const { CategoryName} =
            req.body;

        if (!CategoryName) {
            return res.status(400).json({ message: 'CategoryName is required.' });
        }

        const originalCategory = await db.Categories.findByPk(id);
        if (!originalCategory) {
            return res.status(404).json({ message: 'Category not found.' });
        }

        const updateData: Partial<CategoriesData> = {};
        const changedFields: ChangedFields = {};

        if (CategoryName !== originalCategory.CategoryName) {
            updateData.CategoryName = CategoryName;
            changedFields.CategoryName = { dataUpdated: CategoryName };
        }
       

        if (Object.keys(updateData).length > 0) {
            await db.sequelize.query(
                `UPDATE Categories
     SET 
     ${Object.keys(updateData)
                    .map((field) => `${field} = :${field}`)
                    .join(', ')},
     Date_Modified = GETDATE()
     WHERE CategoryID = :CategoryID`,
                {
                    replacements: {
                        ...updateData,
                        CategoryID: id,
                    },
                    type: QueryTypes.UPDATE,
                }
            );

            return res.status(200).json({
                message: 'Category updated successfully.',
                updatedFields: changedFields,
            });
        } else {
            return res.status(200).json({ message: 'No changes detected.' });
        }
    } catch (error) {
        console.error('Error updating category:', error);
        res.status(500).json({ message: 'Error updating category.' });
    }
}
export const categoryService = {
    getAll, getCategoryById, postCategory, remove, putCategory
}

export default categoryService;
