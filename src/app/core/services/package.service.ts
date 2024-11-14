import { HttpClient, HttpErrorResponse } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { catchError, map, Observable, retry, tap, throwError } from "rxjs";
import { Package } from "../../interfaces/package";

@Injectable({
    providedIn: 'root'
})
export class PackageService {
    private apiUrl = 'http://localhost:8080/api/package/';  // URL to web API
    
    constructor(private http: HttpClient) {}

    getPackages(): Observable<Package[]> {
        return this.http.get<any>(`${this.apiUrl}all`).pipe(
            tap(packages => console.log('Fetched packages:', packages)),
            map(response => response.data),
            retry(3), // Retry up to 3 times
            catchError(this.handleError)
        );
    }

    private handleError(error: HttpErrorResponse) {
        let errorMessage = 'An error occurred';
        if (error.error instanceof ErrorEvent) {
            // A client-side or network error occurred. Handle it accordingly.
            errorMessage = `An error occurred: ${error.error.message}`;
        } else {
            // Server-side errors
            errorMessage = `Server returned code: ${error.status}, error message is: ${error.message}`
        }
        console.error(errorMessage);
        return throwError(() => new Error(errorMessage));
    }
}