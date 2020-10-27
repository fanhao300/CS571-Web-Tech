import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavBarComponent } from './nav-bar/nav-bar.component';
import { SearchComponent } from './search/search.component';
import { WatchlistComponent } from './watchlist/watchlist.component';
import { PortfolioComponent } from './portfolio/portfolio.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { StockDetailComponent } from './stock-detail/stock-detail.component';
import { StockDetailSummaryComponent } from './stock-detail-summary/stock-detail-summary.component';
import { StockDetailNewsComponent } from './stock-detail-news/stock-detail-news.component';
import { StockDetailChartsComponent } from './stock-detail-charts/stock-detail-charts.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatTabsModule } from '@angular/material/tabs';
import { HighchartsChartModule } from 'highcharts-angular';
import { StockDetailNewsSubwindowComponent } from './stock-detail-news-subwindow/stock-detail-news-subwindow.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    SearchComponent,
    WatchlistComponent,
    PortfolioComponent,
    StockDetailComponent,
    StockDetailSummaryComponent,
    StockDetailNewsComponent,
    StockDetailChartsComponent,
    StockDetailNewsSubwindowComponent
  ],
  imports: [
    HttpClientModule,  
    BrowserModule,
    AppRoutingModule,
    FontAwesomeModule,
    BrowserAnimationsModule,
    MatTabsModule,
    HighchartsChartModule,
    NgbModule,
    FormsModule,
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
