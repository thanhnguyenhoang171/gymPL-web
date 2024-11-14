import { Request, Response, NextFunction } from 'express';
import { verifyToken } from '../utils/jwtUtils'; // Import the JWT utility
import { JwtPayload } from 'jsonwebtoken';

// Define the CustomRequest interface extending Request
export interface CustomRequest extends Request {
    user: JwtPayload; // Adding user field to request
}

// Middleware to protect routes that require authentication
export const auth = async (req: Request, res: Response, next: NextFunction) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Get token from Authorization header

    if (!token) {
        return res.status(403).json({ message: 'No token provided' });
    }

    try {
        const decoded = verifyToken(token);

        if (decoded) {
            (req as CustomRequest).user = decoded;
        } else {
            return res.status(401).json({ message: 'Invalid or expired token' });
        }

        return next();
    } catch (error) {
        return res.status(401).json({ message: 'Invalid or expired token' });
    }
};
