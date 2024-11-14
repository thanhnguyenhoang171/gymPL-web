import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core'
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { CustomerService } from '../../core/services/customer.service';
import { HttpClientModule } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Customer } from '../../interfaces/customer';

@Component({
  selector: 'app-customers',
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule,
    MatIconModule,
    MatListModule,
    HttpClientModule,
  ],
  templateUrl: './customers.component.html',
  styleUrl: './customers.component.scss'
})
export class CustomersComponent implements AfterViewInit, OnInit {
  displayedColumns: string[] = ['CustomerID', 'CustomerName', 'Gender', 'PhoneNumber', 'DateofBirth', 'PackID', 'Actions'];
  dataSource: MatTableDataSource<Customer>;
  loading = false;

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  selectedCustomer: Customer | null = null;
  customerKeys: (keyof Customer)[] = [];
  errorMessage: string | null = null;

  constructor(private customerService: CustomerService, private router: Router) {
    this.dataSource = new MatTableDataSource<Customer>([]);
  }

  ngOnInit(): void {
    this.loading = true;
    this.customerService.getCustomers().subscribe({
      next: (data: Customer[]) => {
        this.dataSource.data = data;
        this.errorMessage = null;
        this.loading = false;
      },
      error: (error) => {
        console.error("Error fetching customer data: ", error);
        this.errorMessage = "Failed to load customer data. Please try again.";
        this.loading = false;
      },
      complete: () => {
        console.log('Data fetching completed');
      }
    });
  }

  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
  }

  onRowClick(row: Customer) {
    this.selectedCustomer = row;
    this.customerKeys = Object.keys(row) as (keyof Customer)[];
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  formatValue(value: any, key: string): string {
    if (key === 'DateofBirth' && value) {
      return new Date(value).toLocaleDateString();
    }
    return value || ''; // Format other values as needed
  }

  goToPage($myParam: string = ''): void {
    const navigationDetails: string[] = ['/customers/add-customer'];
    if ($myParam.length) {
      navigationDetails.push($myParam);
    }
    this.router.navigate(navigationDetails);
  }
}