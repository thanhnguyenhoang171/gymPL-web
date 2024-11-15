export interface ProductAttributes {
    ProductID: string;
    CategoryID: number;
    ProductName: string;
    Description?: string;
    SupplierID?: string;
    Quantity?: number;
    UnitPrice: number;
    Date_Added?: Date;
    Date_Modified?: Date;
}