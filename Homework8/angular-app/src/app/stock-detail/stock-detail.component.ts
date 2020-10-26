import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { AppService } from '../app.service';
import { StockInf, StockLatestPrice, StockGraphPrice, News} from '../dataFormat';


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
    let date = time.toLocaleDateString('en-US', {timeZone: 'America/Los_Angeles'});
    date = date.slice(6,10) +"-"+ date.slice(0,2) +"-"+ date.slice(3,5);
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

  ngOnInit(): void {
    this.getStockInf();
    this.getStockLastestPrice();
    this.date = this.getDateByTs(Date.now());
    this.getStockSummaryPrice();
    this.getStockHistoricalPrice();
    this.getNews();


    //Refresh every 15 seconds.
    // setInterval(() => this.date = this.getDateByTs(Date.now()), 1000*15);
    // setInterval(() => this.getStockLastestPrice(), 1000*15);

    //Refresh every 4 minutes.
    // setInterval(() => this.getStockSummaryPrice(), 1000*4*60);
    
  }

}
