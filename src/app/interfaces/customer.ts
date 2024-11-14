export interface Customer {
    CustomerID: string;
    CustomerName: string;
    Gender: string;
    PhoneNumber: string;
    DateofBirth: Date | null;
    PackID: string;
    StaffID?: string | null;
    Startdate?: Date | null;
    Note?: string;
    Image?: string;
}
