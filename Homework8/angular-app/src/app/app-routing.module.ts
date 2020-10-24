import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import {SearchComponent} from './search/search.component';
import {PortfolioComponent} from './portfolio/portfolio.component';
import {WatchlistComponent} from './watchlist/watchlist.component';
import { StockDetailComponent } from './stock-detail/stock-detail.component';


const routes: Routes = [
  {path: '', component: SearchComponent},
  {path: 'watchlist', component: WatchlistComponent},
  {path: 'portfolio', component: PortfolioComponent},
  {path: 'detail/:id', component: StockDetailComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
