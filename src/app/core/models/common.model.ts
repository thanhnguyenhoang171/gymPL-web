export interface Account {
    AccountID: number;
    FullName: string;
    UserName: string;
    Email: string;
}

export interface LoginPayLoad {
    UserName?: string;
    Email?: string;
    Password: string;
}

export interface RegisterPayLoad {
    FullName: string;
    UserName: string;
    Email: string;
    PhoneNumber: string;
    Password: string;
}

export interface ApiResponse<T> {
    status?: boolean;
    message?: string;
    error?: string;
    token?: string;
    data: T;
}