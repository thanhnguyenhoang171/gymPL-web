import db from "../data/mssql";
import { Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import { QueryTypes, Op } from "sequelize";
import { generateToken } from "../utils/jwtUtils";

// GET Method (All)
export const get = async (req: Request, res: Response) => {
    try {
        const accounts = await db.Accounts.findAll();
        res.status(200).json(accounts);
    } catch (error) {
        console.error("Error getting accounts:", error);
        res.status(500).json({ message: "Error getting accounts" });
    }
}

export const getDetails = async (req: Request, res: Response) => {
    try {
        const id = req.params.id;
        const account = await db.Accounts.findByPk(id);
        if (!account)
            res.status(404).json({ message: "Account not found." });
        res.status(200).json(account);
    } catch (error) {
        console.error("Error getting account:", error);
        res.status(500).json({ message: "Error getting account" });
    }
}

export const signUp = async (req: Request, res: Response): Promise<any> => {
    const { FullName, UserName, Password, Email, PhoneNumber } = req.body;

    try {
        // Input validation
        if (!FullName || !UserName || !Password || !Email || !PhoneNumber) {
            return res.status(400).json({ message: "Missing required information." });
        }

        // Check existing account
        const existingAccount = await db.Accounts.findOne({ where: { Email } });
        if (existingAccount) {
            return res.status(400).json({ message: "Account already exists." });
        }

        const hashedPassword = await bcrypt.hash(Password, 10);

        // Create account with proper MSSQL options
        await db.sequelize.query(
            `INSERT INTO Account (FullName, UserName, Password, Email, PhoneNumber)
             VALUES (:FullName, :UserName, :Password, :Email, :PhoneNumber)`,
            {
                replacements: {
                    FullName,
                    UserName,
                    Password: hashedPassword,
                    Email,
                    PhoneNumber
                },
                type: QueryTypes.INSERT
            }
        );

        // Get created account without trigger interference
        const createdAccount = await db.Accounts.findOne({
            where: { Email },
            attributes: ['AccountID', 'Email', 'FullName', 'UserName']
        });

        // Generate JWT token
        const token = generateToken({ sub: createdAccount.AccountID });

        return res.status(201).json({
            status: "success",
            message: "Account created successfully",
            data: createdAccount,
            token
        });

    } catch (error) {
        console.error("Error creating account:", error);
        return res.status(500).json({ 
            message: "Error creating account",
            error: error instanceof Error ? error.message : "Unknown error"
        });
    }
};

export const signIn = async (req: Request, res: Response): Promise<any> => {
    const { UserName, Email, Password } = req.body;
    if (!UserName && !Email) {
        return res.status(400).json({ message: "Username or Email is required." });
    }

    const query: any = {};
    if (UserName) 
        query.UserName = UserName;

    if (Email)
        query.Email = Email;

    const account = await db.Accounts.findOne({ where: query });
    if (!account) {
        return res.status(404).json({ message: "Account not found." });
    }

    const passwordMatch = await bcrypt.compare(Password, account.Password);
    if (!passwordMatch) {
        return res.status(401).json({ message: "Invalid password." });
    }

    try {
        const token = generateToken({ sub: account.AccountID });
        return res.status(200).json({
            message: "Login successful.",
            token
        });
    } catch (error) {
        console.error("Error logging in:", error);
        return res.status(500).json({ message: "Error logging in." });
    }
}

export const accountService = {
    get,
    getDetails,
    signUp,
    signIn
}

export default accountService;