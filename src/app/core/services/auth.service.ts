import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Account, ApiResponse, LoginPayLoad, RegisterPayLoad } from '../models/common.model';
import { ApiEndpoints, LocalStorage } from '../constants/constants';
import { catchError, map, throwError } from 'rxjs';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  router = inject(Router);
  constructor(private _http: HttpClient) { }

  register(payLoad: RegisterPayLoad) {
    return this._http.post<ApiResponse<Account>>(
      `${ApiEndpoints.Auth.Register}`, 
      payLoad
    ).pipe(
      catchError(error => {
        console.error('Registration error:', error);
        return throwError(() => new Error(error.error?.message || 'Registration failed'));
      })
    );;
  }

  login(payLoad: LoginPayLoad) {
    return this._http
      .post<ApiResponse<Account>>(`${ApiEndpoints.Auth.Login}`, payLoad)
      .pipe(
        map((response) => {
          if (response.status && response.token) {
            localStorage.setItem(LocalStorage.token, response.token!);
          }
          return response;
        })
      );
  }

  profile() {
    return this._http.get<ApiResponse<Account>>(
      `${ApiEndpoints.Auth.Profile}`
    );
  }

  logout() {
    localStorage.removeItem(LocalStorage.token);
    this.router.navigate(['/login']);
  }
}
