import express from "express";
const router = express.Router();
import productController from "../controllers/productController";

// Define routes
// routes for Package
router.get('/all', productController.getAllProducts);
router.get('/detail', productController.getProductById);
router.post('/add', productController.postProduct);
// router.put('/update', packageController.updatePackage);
router.delete('/delete', productController.deleteProduct);

export default router;