import express from "express";
const router = express.Router();
import { accountController } from "../controllers/accountController";

// Define routes
// routes for Account
router.get('/all', accountController.getAllAccounts);
router.get('/:id', accountController.getAccountById);

export default router;