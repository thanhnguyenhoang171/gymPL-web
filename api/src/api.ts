import dotenv from 'dotenv';
dotenv.config();

import express from "express";
import path from 'path';
import cors from "cors";
import productRoutes from "./routes/product.routes";
import customerRoutes from "./routes/customer.routes";
import packageRoutes from "./routes/package.routes";
import accountRoutes from "./routes/account.routes";
import authRoutes from "./routes/auth.routes";
import categoryRoutes from "./routes/category.routes";
import protectedRoutes from "./routes/protected.routes";
import supplierRoutes from "./routes/supplier.routes";
import DbConnect from "./data/db_sqlserver_connection";
import fileUpload from 'express-fileupload'

const app = express();
const PORT = process.env['PORT'] || 8080;

var corsOptions = {
    origin: ["http://localhost:4200", "http://localhost:8081"],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
};

// Lấy đường dẫn đến thư mục chứa ảnh
// Lấy đường dẫn tới thư mục 'uploadFile' trong 'public'
const publicFolderPath = path.resolve(process.cwd(), 'src', 'public', 'uploadFile');

// Đảm bảo thư mục 'public/uploadFile' có thể được truy cập từ frontend
app.use('/uploadFile', express.static(publicFolderPath));

// config file upload
app.use(fileUpload());

app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// API base path to customers
app.use("/api/supplier", supplierRoutes);
app.use("/api/product", productRoutes);
app.use("/api/category", categoryRoutes);
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
