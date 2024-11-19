import express from "express";
import { categoryController } from "../controllers/categoryController";

const router = express.Router();

router.get('/all', categoryController.getAllCategories);
router.get('/detail', categoryController.getDetailCategory);
router.post('/', categoryController.addCategory);
router.put('/update', categoryController.updateCategory);
router.delete('/delete', categoryController.deleteCategory);

export default router;