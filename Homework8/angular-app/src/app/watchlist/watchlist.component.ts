import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { AppService } from '../app.service';
import { StockLatestPrice, WatchList} from '../dataFormat';

@Component({
  selector: 'app-watchlist',
  templateUrl: './watchlist.component.html',
  styleUrls: ['./watchlist.component.css']
})
export class WatchlistComponent implements OnInit {
  constructor(
    private appService: AppService,
    private router: Router) { }

  watchList: WatchList[];
  stockPriceList: StockLatestPrice[];
  str: string;

  updateWatchList(): void{
    let watchListString = localStorage.getItem("watchList");
    this.watchList = JSON.parse(watchListString);
    
    //sort
    this.watchList.sort((a,b) => {
      if (a.ticker > b.ticker) return 1;
      if (a.ticker < b.ticker) return -1;
      if (a.ticker == b.ticker) return 0;
    });
    watchListString = JSON.stringify(this.watchList);
    localStorage.setItem("watchList", watchListString);
  }

  getStocksString(): string{
    if (this.watchList.length == 0) return "";
    let ret: string = "";
    for (let i = 0; i < this.watchList.length; ++i){
      ret += this.watchList[i].ticker + ',';
    }
    return ret;
  }
 

  getStocks(tickers: string): void{
    if (tickers.length == 0) return;
    this.appService.getMultipleStocksLastestPrice(tickers)
      .subscribe(stocksPriceList => this.stockPriceList = stocksPriceList);
  }

  deleteWatchlist(ticker:string): void{
    let watchListString = localStorage.getItem("watchList");
    this.watchList = JSON.parse(watchListString);
    for (let i = 0; i < this.watchList.length; ++i){
      if (this.watchList[i].ticker == ticker){
        //update watchList
        this.watchList.splice(i, 1);
        //update stock list
        this.stockPriceList.splice(i, 1);
        break;
      }
    }
    watchListString = JSON.stringify(this.watchList);
    localStorage.setItem("watchList", watchListString);
  }

  cardClick(ticker: string): void{
    this.router.navigateByUrl('/detail/' + ticker);
  }

  numberWithCommas(x, isDecimal: boolean) {
    // If x cannot convert to number
    if (isNaN(Number(x))) return x;
    else {
      x = Number(x);
    }

    //convert x
    let parts: string[];
    if (isDecimal){
      parts = x.toFixed(2).split(".");
    }
    else {
      parts = x.toString().split(".");
    }
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
  }
  
  ngOnInit(){
    this.updateWatchList();
    this.getStocks(this.getStocksString());
  }

}
