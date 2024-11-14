import dotenv from 'dotenv';
dotenv.config();

import express from "express";
import cors from "cors";
import customerRoutes from "./routes/customer.routes";
import packageRoutes from "./routes/package.routes";
import accountRoutes from "./routes/account.routes";
import authRoutes from "./routes/auth.routes";
import protectedRoutes from "./routes/protected.routes";
import DbConnect from "./data/db_sqlserver_connection";


const app = express();
const PORT = process.env['PORT'] || 8080;

var corsOptions = {
    origin: ["http://localhost:4200", "http://localhost:8081"],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
};

app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// API base path to customers
app.use("/api/customer", customerRoutes);
app.use("/api/package", packageRoutes);
app.use("/api/account", accountRoutes);
app.use("/api/auth", authRoutes);
app.use("/api", protectedRoutes);

DbConnect();

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

app.get("/hello", (req, res) => {
    res.json({ message: "Welcome to GymPhuongLuu Web" });
});

