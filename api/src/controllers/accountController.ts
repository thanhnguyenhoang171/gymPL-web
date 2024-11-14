import { Request, Response } from 'express';
import accountService from "../services/account.service";

// GET Method (All)
export const getAllAccounts = async (req: Request, res: Response) => {
    try {
        await accountService.get(req, res);
    } catch (error) {
        console.error("Error getting accounts:", error);
        res.status(500).json({ message: "Error getting accounts" });
    }
}

export const getAccountById = async (req: Request, res: Response) => {
    try {
        await accountService.getDetails(req, res);
    } catch (error) {
        console.error("Error getting account:", error);
        res.status(500).json({ message: "Error getting account" });
    }
}

export const register = async (req: Request, res: Response): Promise<any> => {
    try {
        await accountService.signUp(req, res);
    } catch (error) {
        console.error("Error creating account:", error);
        return res.status(500).json({ 
            message: "Error creating account",
            error: error instanceof Error ? error.message : "Unknown error"
        });
    }
};

export const login = async (req: Request, res: Response): Promise<any> => {
    try {
        await accountService.signIn(req, res);
    } catch (error) {
        console.error("Error logging in:", error);
        return res.status(500).json({ message: "Error logging in." });
    }
}

export const accountController = {
    getAllAccounts,
    getAccountById,
    register,
    login
}

export default accountController;