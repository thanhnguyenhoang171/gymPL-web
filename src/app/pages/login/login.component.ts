import { ChangeDetectionStrategy, Component, inject, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';
import { CommonModule } from '@angular/common';
import { LoginPayLoad } from '../../core/models/common.model';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class LoginComponent {
  form: FormGroup;
  authService = inject(AuthService);

  constructor(
    private router: Router,
    private fb: FormBuilder
  ) {
    this.form = this.fb.group({
      emailOrUsername: new FormControl('', [Validators.required, this.emailOrUsernameValidator.bind(this)]),
      password: new FormControl('', [Validators.required])
    })
  }

  private emailOrUsernameValidator(control: AbstractControl) {
    if (!control.value) {
      return { required: true };
    }
    // Regex to check for a valid email
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (emailRegex.test(control.value)) {
      return null; // valid email
    }
    // Check if it's a username (non-empty value)
    if (control.value.trim().length > 0) {
      return null; // valid username
    }
    return { invalid: true }; // invalid input
  }

  onSubmit() {
    if (this.form.valid) {
      // Log form values to check the request body
      console.log(this.form.value); // This should log emailOrUsername and password
  
      // Construct the payload based on the input
      const loginPayload: LoginPayLoad = {
        Password: this.form.value.password,  // Password is required in both cases
      };
  
      // If the input looks like an email, add Email to the payload
      const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
      if (emailRegex.test(this.form.value.emailOrUsername)) {
        loginPayload.Email = this.form.value.emailOrUsername;
      } else {
        // Otherwise, treat it as a username
        loginPayload.UserName = this.form.value.emailOrUsername;
      }
  
      // Send the payload to the backend
      this.authService.login(loginPayload).subscribe({
        next: () => {
          this.router.navigate(['/dashboard']);
        },
        error: (error) => {
          console.error("Error logging in: ", error);
        }
      });
    }
  }
  

  goToSignUp($myParam: string = ''): void {
    const navigationDetails: string[] = ['/register'];
    if ($myParam.length) {
      navigationDetails.push($myParam);
    }
    this.router.navigate(navigationDetails);
  }
}
