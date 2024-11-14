import { Router, Request, Response, NextFunction } from 'express';
import { auth, CustomRequest } from '../middlewares/authMiddleware';
import db from '../data/mssql';

// Account interface
interface AccountResponse {
    FullName: string;
    UserName: string;
    Email: string;
    PhoneNumber: string;
    Status: string;
}

const router = Router();

// Type assertion for auth middleware
const authMiddleware = auth as (
    req: Request, 
    res: Response, 
    next: NextFunction
) => Promise<void>;

router.get('/profile', authMiddleware, async (req: Request, res: Response): Promise<void> => {
    try {
        const accountId = (req as CustomRequest).user?.sub;
        
        if (!accountId) {
            res.status(401).json({ message: 'Unauthorized' });
            return;
        }

        const account = await db.Accounts.findByPk(accountId);

        if (!account) {
            res.status(404).json({ message: 'Account not found' });
            return;
        }

        const accountResponse: AccountResponse = {
            FullName: account.FullName,
            UserName: account.UserName,
            Email: account.Email,
            PhoneNumber: account.PhoneNumber,
            Status: account.Status,
        };

        res.json({
            message: 'Account details fetched successfully',
            account: accountResponse
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
});

export default router;