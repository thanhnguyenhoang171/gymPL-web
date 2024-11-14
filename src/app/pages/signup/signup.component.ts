import { CommonModule } from '@angular/common';
import { Component, inject, signal } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSnackBar } from '@angular/material/snack-bar';
import { AuthService } from '../../core/services/auth.service';
import { Router } from '@angular/router';
import { RegisterPayLoad } from '../../core/models/common.model';

interface SignupResponse {
  status: boolean;
}

@Component({
  selector: 'app-signup',
  standalone: true,
  imports: [
    CommonModule,
    MatFormFieldModule,
    MatInputModule,
    ReactiveFormsModule
  ],
  templateUrl: './signup.component.html',
  styleUrl: './signup.component.scss'
})
export class SignupComponent {
  isLoading = false;
  protected readonly value = signal('');
  customerForm: FormGroup;
  authService = inject(AuthService);
  private passwordMatchValidator = (control: AbstractControl): ValidationErrors | null => {
    const password = control.get('password')?.value;
    const confirmPassword = control.get('confirmPassword')?.value;
    return password === confirmPassword ? null : { passwordMismatch: true };
  };

  constructor(private fb: FormBuilder, private snackBar: MatSnackBar, private router: Router) {
    this.customerForm = this.fb.nonNullable.group({
      fullName: ['', Validators.required],
      username: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      phoneNumber: ['', Validators.required],
      password: ['', Validators.required],
      confirmPassword: ['', Validators.required]
    }, { validators: this.passwordMatchValidator });
  }

  onSubmit() {
    if (this.customerForm.valid) {
      this.isLoading = true;
      
      const registerData: RegisterPayLoad = {
        FullName: this.customerForm.value.fullName,
        UserName: this.customerForm.value.username,
        Password: this.customerForm.value.password,
        Email: this.customerForm.value.email,
        PhoneNumber: this.customerForm.value.phoneNumber
      };

      this.authService.register(registerData).subscribe({
        next: (response) => {
          this.snackBar.open('Đăng ký thành công!', 'Đóng', {
            duration: 3000
          });
          this.router.navigate(['/login']);
        },
        error: (error) => {
          this.snackBar.open('Đăng ký thất bại: ' + error.message, 'Đóng', {
            duration: 3000
          });
        },
        complete: () => {
          this.isLoading = false;
        }
      });
    }
  }

  protected onInput(e: Event): void {
    const target = e.target as HTMLInputElement;
    if (target) {
      this.value.set(target.value);
    }
  }
}
