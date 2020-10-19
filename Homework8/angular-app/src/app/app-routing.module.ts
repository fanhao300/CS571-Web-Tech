import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import {SearchComponent} from './search/search.component';
import {PortfolioComponent} from './portfolio/portfolio.component';
import {WatchlistComponent} from './watchlist/watchlist.component';


const routes: Routes = [
  {path: '', component: SearchComponent},
  {path: 'watchlist', component: WatchlistComponent},
  {path: 'portfolio', component: PortfolioComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
