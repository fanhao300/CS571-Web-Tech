import { JsonPipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { getTsBuildInfoEmitOutputFilePath } from 'typescript';

import { AppService } from '../app.service';
import { StockLatestPrice, Portfolio} from '../dataFormat';

@Component({
  selector: 'app-portfolio',
  templateUrl: './portfolio.component.html',
  styleUrls: ['./portfolio.component.css']
})

export class PortfolioComponent implements OnInit {

  constructor(
    private appService: AppService,
    private router: Router
  ) { }

  portfolio: Portfolio[] = [];
  stockPriceList: StockLatestPrice[];

  getStocksString(): string{
    if (this.portfolio.length == 0) return "";
    let ret: string = "";
    for (let i = 0; i < this.portfolio.length; ++i){
      ret += this.portfolio[i].ticker + ',';
    }
    return ret;
  }
 
  getStocks(tickers: string): void{
    if (tickers.length == 0) return;
    this.appService.getMultipleStocksLastestPrice(tickers)
      .subscribe(stocksPriceList => this.stockPriceList = stocksPriceList);
  }

  updatePortfolio(useless:string): void{
    let portfolioString = localStorage.getItem("portfolio");
    this.portfolio = JSON.parse(portfolioString);
    for (let i = 0; i < this.portfolio.length; ++i){
      if (this.portfolio[i].quantity == 0){
        this.portfolio.splice(i,1);
        this.stockPriceList.splice(i, 1);
        break;
      }
    }

    this.portfolio.sort((a,b) => {
      if (a.ticker > b.ticker) return 1;
      if (a.ticker < b.ticker) return -1;
      if (a.ticker == b.ticker) return 0;
    });

    portfolioString = JSON.stringify(this.portfolio);
    localStorage.setItem("portfolio", portfolioString);
      
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

  ngOnInit(): void {
    this.updatePortfolio("useless"); 
    this.getStocks(this.getStocksString());
  }

}
