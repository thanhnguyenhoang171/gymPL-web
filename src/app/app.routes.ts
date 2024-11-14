import { Routes } from '@angular/router';
import { CustomersComponent } from './pages/customers/customers.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { AddCustomerComponent } from './pages/customers/add-customer/add-customer.component';
import { LoginComponent } from './pages/login/login.component';
import { SidenavComponent } from './shared/components/layouts/admin/sidenav/sidenav.component';
import { SignupComponent } from './pages/signup/signup.component';

export const routes: Routes = [
    // { path: '', redirectTo: 'login', pathMatch: 'full' },
    // { path: 'login', component: LoginComponent },
    // {
    //     path: 'admin',
    //     component: SidenavComponent,
    //     children: [
    //         { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
    //         { path: 'dashboard', component: DashboardComponent },
    //         { path: 'customers', component: CustomersComponent },
    //         { path: 'customers/add-customer', component: AddCustomerComponent }
    //     ]
    // }
    { path: '', redirectTo: 'login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'register', component: SignupComponent },
    { path: 'dashboard', component: DashboardComponent },
    { path: 'customers', component: CustomersComponent },
    { path: 'customers/add-customer', component: AddCustomerComponent }
];
