import { Injectable } from "@angular/core";
import { HttpClient, HttpErrorResponse, HttpParams } from "@angular/common/http";
import { catchError, Observable, of, Subject, throwError } from "rxjs";
import { map, retry } from "rxjs/operators";
import { Customer } from "../../interfaces/customer";
import { environment } from "../../../environments/environment.development";
import { ChangeDetectorRef } from '@angular/core';

@Injectable({
    providedIn: 'root'
})
export class CustomerService {
    private apiUrl = 'http://localhost:8080/api/customer/';  // URL to web API

    constructor(private http: HttpClient) { }

    getImagePath(imagePath: string): string {
        return imagePath.replace(/\\/g, '/');
    }

    getCustomers(): Observable<Customer[]> {
        return this.http.get<{ data: Customer[] }>(`${this.apiUrl}all`).pipe(
            map((response) => {
                const customers = response.data;

                if (!Array.isArray(customers)) {
                    throw new Error('Unexpected response format: not an array');
                }

                return customers.map(customer => ({
                    CustomerID: customer.CustomerID,
                    CustomerName: customer.CustomerName,
                    Gender: customer.Gender,
                    PhoneNumber: customer.PhoneNumber,
                    DateofBirth: customer.DateofBirth ? new Date(customer.DateofBirth) : null,
                    PackID: customer.PackID,
                    Image: customer.Image ? this.getImagePath(customer.Image) : '../../../assets/logo/387807896_664506269107075_8224171808058164020_n.jpg', // Chuyển đổi đường dẫn hình ảnh
                }));
            }),
            retry(3), // Retry up to 3 times
            catchError(this.handleError)
        );
    }

    addCustomer(customer: Customer, queryParam?: any): Observable<Customer | null> {
        let params = new HttpParams();
        if (queryParam && queryParam.key) {
            params = params.append('key', queryParam.key);
        }

        return this.http.post<Customer>(this.apiUrl, customer, { params }).pipe(
            catchError(error => {
                console.error('Error adding customer:', error);
                return of(null);
            })
        );
    }

    updateCustomer(customer: Customer): Observable<Customer | null> {
        const url = `${this.apiUrl}update?id=${customer.CustomerID}`;

        // Format Startdate to YYYY-MM-DD HH:MM:SS
        const formattedStartdate = customer.Startdate
            ? `${customer.Startdate.getFullYear()}-${String(customer.Startdate.getMonth() + 1).padStart(2, '0')}-${String(customer.Startdate.getDate()).padStart(2, '0')} ${String(customer.Startdate.getHours()).padStart(2, '0')}:${String(customer.Startdate.getMinutes()).padStart(2, '0')}:${String(customer.Startdate.getSeconds()).padStart(2, '0')}`
            : null;

        // Format DateofBirth to YYYY-MM-DD without time
        const formattedDateofBirth = customer.DateofBirth
            ? `${new Date(customer.DateofBirth).toISOString().split('T')[0]}`
            : null;

        return this.http.put<Customer>(url, {
            CustomerName: customer.CustomerName,
            Gender: customer.Gender,
            DateofBirth: formattedDateofBirth,
            PhoneNumber: customer.PhoneNumber,
            PackID: customer.PackID,
            StaffID: customer.StaffID,
            Startdate: formattedStartdate,
            Note: customer.Note
        }).pipe(
            catchError(error => {
                console.error('Error updating customer:', error);
                return of(null);
            })
        );
    }

    private handleError(error: HttpErrorResponse) {
        let errorMessage = 'An error occurred';
        if (error.error instanceof ErrorEvent) {
            // Client-side error
            errorMessage = `Error: ${error.error.message}`;
        } else {
            // Server-side error
            errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
        }
        console.error(errorMessage);
        return throwError(() => new Error(errorMessage));
    }
}