import express from "express";
import { customerController } from "../controllers/customerController";

const router = express.Router();

// Define routes
// routes for Customer
router.get('/all', customerController.getAllCustomers);
router.get('/detail', customerController.getCustomerById);
router.post('/', customerController.addCustomer);
router.put('/update', customerController.updateCustomer);
router.delete('/delete', customerController.deleteCustomer);

router.post('/uploadfile', customerController.uploadFileCustomer);

export default router;