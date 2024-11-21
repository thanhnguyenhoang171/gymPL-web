
import express from "express";
const router = express.Router();
import supplierController from "../controllers/supplierController";

// Define routes
// routes for Supplier
router.get('/all', supplierController.getAllSuppliers);
router.get('/detail', supplierController.getSupplierById);
router.post('/add', supplierController.postSupplier);
router.put('/update', supplierController.updateSupplier);
router.delete('/delete', supplierController.deleteSupplier);

export default router;