import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SidenavComponent } from "./shared/components/layouts/admin/sidenav/sidenav.component";
import { BodyComponent } from "./shared/components/layouts/body/body.component";
import { HeaderComponent } from './shared/components/layouts/admin/header/header.component'

interface SideNavToggle {
  screenWidth: number;
  collapsed: boolean;
}

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule, 
    SidenavComponent, 
    BodyComponent,
    HeaderComponent
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'gympl-web-management';

  isSideNavCollapsed = false;
  screenWidth = 0;

  onToggleSideNav(data: SideNavToggle): void {
    this.screenWidth = data.screenWidth;
    this.isSideNavCollapsed = data.collapsed;
  }
}
