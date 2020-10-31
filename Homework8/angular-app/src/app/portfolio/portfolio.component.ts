import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { getTsBuildInfoEmitOutputFilePath } from 'typescript';

import { AppService } from '../app.service';
import { StockInf, StockLatestPrice, Portfolio} from '../dataFormat';

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
    for (let i = 0; i <this.portfolio.length; ++i){
      this.getStockInf(this.portfolio[i].ticker, i);
      this.getStockLastestPrice(this.portfolio[i].ticker, i);
    }
  }

  getPortfolio(): void{
    let portfolioString = localStorage.getItem("portfolio");
    this.portfolio = JSON.parse(portfolioString);
  }

  updatePortfolio(useless:string): void{
    let portfolioString = localStorage.getItem("portfolio");
    this.portfolio = JSON.parse(portfolioString);
    for (let i = 0; i < this.portfolio.length; ++i){
      if (this.portfolio[i].quantity == 0){
        this.portfolio.splice(i,1);
        portfolioString = JSON.stringify(this.portfolio);
        localStorage.setItem("portfolio", portfolioString);
        
        this.stockInfList.splice(i, 1);
        this.isFinishedInf.splice(i, 1);
        this.stockPriceList.splice(i, 1);
        this.isFinishedPrice.splice(i, 1);
        break;
      }
    }
  }


  isFinished(): boolean{
    for (let i = 0; i < this.portfolio.length; ++i){
      if (this.isFinishedPrice[i] && this.isFinishedInf[i]){
        continue;
      }
      else {
        return false;
      }
    }
    return true;
  }

  cardClick(ticker: string): void{
    this.router.navigateByUrl('/detail/' + ticker);
  }

  ngOnInit(): void {
    this.getPortfolio(); 
    this.getStocks();
  }

}
