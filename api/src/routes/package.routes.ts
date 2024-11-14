import express from "express";
const router = express.Router();
import packageController from "../controllers/packageController";

// Define routes
// routes for Package
router.get('/all', packageController.getAllPackages);
// router.get('/detail', packageController.getPackageById);
// router.post('/', packageController.addPackage);
// router.put('/update', packageController.updatePackage);
// router.delete('/delete', packageController.deletePackage);

export default router;