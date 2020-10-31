import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { AppService } from '../app.service';
import { StockInf, StockLatestPrice, } from '../dataFormat';

@Component({
  selector: 'app-watchlist',
  templateUrl: './watchlist.component.html',
  styleUrls: ['./watchlist.component.css']
})
export class WatchlistComponent implements OnInit {
  constructor(
    private appService: AppService,
    private router: Router) { }

  watchList: string[];

  stockInfList: StockInf[] = [];
  isFinishedInf: boolean[] = [];
  stockPriceList: StockLatestPrice[] = [];
  isFinishedPrice: boolean[] = [];

  
  getStockInf(ticker: string, cnt: number): void{
    this.appService.getStockInf(ticker)
      .subscribe(stockInf => this.stockInfList[cnt] = stockInf,
        (err) => console.log(err),
        () => this.isFinishedInf[cnt] = true);
  }

  getStockLastestPrice(ticker: string, cnt: number): void{
    this.appService.getStockLastestPrice(ticker)
      .subscribe(stockPrice => this.stockPriceList[cnt] = stockPrice,
        (err) => console.log(err),
        () => this.isFinishedPrice[cnt] = true);
  }


  getStocks(): void{
    for (let i = 0; i <this.watchList.length; ++i){
      this.getStockInf(this.watchList[i], i);
      this.getStockLastestPrice(this.watchList[i], i);
    }
  }

  updateWatchList(): void{
    let watchListString = localStorage.getItem("watchList");
    this.watchList = watchListString.split(",");
    this.watchList.splice(this.watchList.length - 1 , 1);
    this.watchList.sort();
  }

  isFinished(): boolean{
    for (let i = 0; i < this.watchList.length; ++i){
      if (this.isFinishedPrice[i] && this.isFinishedInf[i]){
        continue;
      }
      else {
        return false;
      }
    }
    return true;
  }

  deleteWatchlist(ticker:string, index:number): void{
    //update watchList
    let watchListString = localStorage.getItem("watchList");
    watchListString = watchListString.replace(ticker+',', '');
    localStorage.setItem("watchList", watchListString);
    this.updateWatchList();

    //update stock list
    this.stockInfList.splice(index, 1);
    this.isFinishedInf.splice(index, 1);
    this.stockPriceList.splice(index, 1);
    this.isFinishedPrice.splice(index, 1);
  }

  cardClick(ticker: string): void{
    this.router.navigateByUrl('/detail/' + ticker);
  }

  ngOnInit(){
    this.updateWatchList();
    this.getStocks();
  }

}
