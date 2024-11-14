import express from "express";
const router = express.Router();
import { accountController } from "../controllers/accountController";

// Define routes
router.post('/register', accountController.register);
router.post('/login', accountController.login);

export default router;