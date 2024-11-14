import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatFormField } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MAT_DATE_LOCALE, provideNativeDateAdapter } from '@angular/material/core';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { PackageService } from '../../../core/services/package.service';
import { CustomerService } from '../../../core/services/customer.service';
import { Router } from '@angular/router';
import { Customer } from '../../../interfaces/customer';
import { Package } from '../../../interfaces/package';
import {MatStepperModule} from '@angular/material/stepper';
import { STEPPER_GLOBAL_OPTIONS } from '@angular/cdk/stepper';

@Component({
  selector: 'app-add-customer',
  standalone: true,
  imports: [
    CommonModule,
    MatFormField,
    MatInputModule,
    FormsModule,
    ReactiveFormsModule,
    MatSelectModule,
    MatDatepickerModule,
    MatCardModule,
    MatButtonModule,
    MatStepperModule
  ],
  templateUrl: './add-customer.component.html',
  styleUrl: './add-customer.component.scss',
  providers: [
    {
      provide: MAT_DATE_LOCALE, 
      useValue: 'vi-VN'
    },
    provideNativeDateAdapter(),
    {
      provide: STEPPER_GLOBAL_OPTIONS,
      useValue: {showError: true}
    }
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AddCustomerComponent implements OnInit {
  firstFormGroup = this._formBuilder.group({
    firstCtrl: ['', Validators.required],
  });

  secondFormGroup = this._formBuilder.group({
    secondCtrl: ['', Validators.required],
  });

  packages: Package[] = [];

  constructor(
    private _formBuilder: FormBuilder,
    private router: Router,
    private builder: FormBuilder,
    private packageService: PackageService,
    private customerService: CustomerService,
  ) {}

  ngOnInit() {
    this.packageService.getPackages().subscribe({
      next: (data) => {
        console.log(Array.isArray(data) ? 'Fetched packages:' : 'Unexpected response format: not an array', data);
        this.packages = data;
      },
      error: (error) => {
        console.error('Error fetching package data:', error);
      }
    });
  }

  customerForm = this.builder.group({
    customerId: this.builder.control({value: '', disabled: true}),
    customerName: this.builder.control('', Validators.required),
    gender: this.builder.control('', Validators.required),
    phoneNumber: this.builder.control('', Validators.required),
    dateOfBirth: this.builder.control(new Date(), Validators.required),
    packId: this.builder.control('', Validators.required),
    staffId: this.builder.control(null),
    note: this.builder.control('')
  });

  onSubmit() {
    if (this.customerForm.valid) {
      const formData = this.customerForm.getRawValue();  // Retrieve all form values

      // Map form data to match CustomerData structure
      const customerData: Customer = {
        CustomerID: formData.customerId ?? '',
        CustomerName: formData.customerName ?? '',
        Gender: formData.gender ?? '',
        PhoneNumber: formData.phoneNumber ?? '',
        DateofBirth: formData.dateOfBirth ?? null,
        PackID: formData.packId ?? '',
        StaffID: formData.staffId ?? null,
        Note: formData.note ?? ''
      };

      this.customerService.addCustomer(customerData).subscribe({
        next: (response) => {
          if (response) {
            console.log('Customer added successfully:', response);
            // Optional: Reset form or give success message
          } else {
            console.log('No response received, possibly an error occurred.');
          }
        },
        error: (error) => console.error('Error submitting customer data:', error),
      });
    } else {
      console.log('Form is invalid');
    }
  }

  onCancel() {
    this.router.navigate(['/customers']);
  }
}
