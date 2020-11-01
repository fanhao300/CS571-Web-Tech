import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import {Subject} from 'rxjs';
import {debounceTime} from 'rxjs/operators';

import { AppService } from '../app.service';
import { StockInf, StockLatestPrice, StockGraphPrice, News, WatchList} from '../dataFormat';


@Component({
  selector: 'app-stock-detail',
  templateUrl: './stock-detail.component.html',
  styleUrls: ['./stock-detail.component.css']
})
export class StockDetailComponent implements OnInit {

  constructor(
    private route: ActivatedRoute,
    private appService: AppService) { }

  stockInf: StockInf;
  stockLatestPrice: StockLatestPrice;
  date: string;
  stockSummaryPrice: StockGraphPrice[];
  stockHistoricalPrice: StockGraphPrice[];
  newsList: News[]; 

  addSuccessful: boolean;
  deleteSuccessful: boolean;
  buySuccessful: boolean;
  private addSuccessSubject = new Subject<boolean>();
  private deleteSuccessSubject = new Subject<boolean>();
  private buySuccessSubject = new Subject<boolean>();

  getStockInf(): void{
    let id: string = this.route.snapshot.paramMap.get('id');
    this.appService.getStockInf(id)
      .subscribe(stockInf => this.stockInf = stockInf);
  }

  getStockLastestPrice(): void{
    let id: string = this.route.snapshot.paramMap.get('id');
    this.appService.getStockLastestPrice(id)
      .subscribe(stockLatestPrice => this.stockLatestPrice = stockLatestPrice);
  }

  getStockSummaryPrice(): void{
    let id: string = this.route.snapshot.paramMap.get('id');
    this.appService.getStockSummaryPrice(id)
      .subscribe(stockSummaryPrice => this.stockSummaryPrice = stockSummaryPrice);
  }

  getStockHistoricalPrice(): void{
    let id: string = this.route.snapshot.paramMap.get('id');
    this.appService.getStockHistoricalPrice(id)
      .subscribe(stockHistoricalPrice => this.stockHistoricalPrice = stockHistoricalPrice);
  }

  getNews():void{
    let id: string = this.route.snapshot.paramMap.get('id');
    this.appService.getNews(id)
      .subscribe(newsList => this.newsList = newsList);
  }

  getDateByTs(ts: number): string{
    let time = new Date(ts);
    let date = time.toLocaleDateString('en-GB', {timeZone: 'America/Los_Angeles'});
    date = date.slice(6,10) +"-"+ date.slice(3,5) +"-"+ date.slice(0,2);
    let ret = date + " "
        + time.toLocaleTimeString('en-GB', {timeZone: 'America/Los_Angeles'});
    return ret;
  }

  // The format of time is yyyy-mm-ddThh:mm:ss
  getDateByUTC(time: string): string{
    let date = new Date(time);
    return this.getDateByTs(date.getTime());
  }

  isMarketOpen(time: string): boolean{
    let ret: boolean = false;
    let timeNow = new Date();
    let timeCheck = new Date(time);
    if (timeNow.getTime() - timeCheck.getTime() < 60 * 1000)
      ret = true;
    return ret;
  }

  isInWatchlist(ticker: string): boolean{
    let watchListString = localStorage.getItem("watchList");
    let watchList = JSON.parse(watchListString);
    for (let i = 0; i < watchList.length; ++i){
      if (watchList[i].ticker == ticker) return true;
    }
    return false;
  }

  deleteTickerFromWatchlist(ticker:string): void{
    let watchListString = localStorage.getItem("watchList");
    let watchList = JSON.parse(watchListString);
    for (let i = 0; i < watchList.length; ++i){
      if (watchList[i].ticker == ticker){
        watchList.splice(i,1);
      }
    }
    watchListString = JSON.stringify(watchList);
    localStorage.setItem("watchList", watchListString);

    this.deleteSuccessSubject.next(true);
    this.addSuccessSubject.next(false);
  }


  addTickerFromWatchList(ticker:string, name:string): void{
    let watchListString = localStorage.getItem("watchList");
    let watchList:WatchList[] = JSON.parse(watchListString);
    let item: WatchList ={
      ticker: ticker,
      name: name
    }
    watchList.push(item);
    watchListString = JSON.stringify(watchList);
    localStorage.setItem("watchList", watchListString);

    this.addSuccessSubject.next(true);
    this.deleteSuccessSubject.next(false);
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

  afterBuyStock(useless: string): void{
    this.buySuccessSubject.next(true);
  }


  ngOnInit(): void {
    //get stock information 
    this.getStockInf();
    this.getStockLastestPrice();
    this.date = this.getDateByTs(Date.now());
    this.getStockSummaryPrice();
    this.getStockHistoricalPrice();
    this.getNews();

    //register subjexts for alert
    this.addSuccessSubject.subscribe(message => this.addSuccessful = message);
    this.addSuccessSubject.pipe(
      debounceTime(5000)
    ).subscribe(() => this.addSuccessful = false);

    this.deleteSuccessSubject.subscribe(message => this.deleteSuccessful = message);
    this.deleteSuccessSubject.pipe(
      debounceTime(5000)
    ).subscribe(() => this.deleteSuccessful = false);

    this.buySuccessSubject.subscribe(message => this.buySuccessful = message);
    this.buySuccessSubject.pipe(
      debounceTime(5000)
    ).subscribe(() => this.buySuccessful = false);



    //Refresh every 15 seconds.
    // setInterval(() => this.date = this.getDateByTs(Date.now()), 1000*15);
    // setInterval(() => this.getStockLastestPrice(), 1000*15);

    //Refresh every 4 minutes.
    // setInterval(() => this.getStockSummaryPrice(), 1000*15);
    
  }

}
