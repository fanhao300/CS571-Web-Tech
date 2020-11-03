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
  tempStockPriceList: StockLatestPrice[];
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
   
    if (this.tempStockPriceList){
      for (let i = 0; i < this.stockPriceList.length; ++i)
        for (let j = 0; j < this.tempStockPriceList.length; ++j){
          if (this.stockPriceList[i].ticker == this.tempStockPriceList[j].ticker) {
            this.stockPriceList[i] = this.tempStockPriceList[j];
            break;
          }
        }
    }
    
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

  getTempStocks(tickers: string){
    if (tickers.length == 0) return;
    this.appService.getMultipleStocksLastestPrice(tickers)
      .subscribe(stocksPriceList => this.tempStockPriceList = stocksPriceList);
  }
  
  ngOnInit(){
    this.updateWatchList();
    this.getStocks(this.getStocksString());

    //when develop, comment this line;
    setInterval(() => this.getTempStocks(this.getStocksString()), 15 * 1000);

  }

}
