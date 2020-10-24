import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { AppService } from '../app.service';
import {StockInf, StockLatestPrice} from '../dataFormat';


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

  getnowdate(): string{
    let ts = Date.now();
    let time = new Date(ts);
    let date = time.toLocaleDateString('en-US');
    date = date.slice(6,10) +"-"+ date.slice(0,2) +"-"+ date.slice(3,5);
    let ret = date + " "
        + time.toLocaleTimeString('en-GB');
    return ret;
  }

  ngOnInit(): void {
    this.getStockInf();
    this.getStockLastestPrice();
    this.date = this.getnowdate();
    setInterval(() => this.date = this.getnowdate(), 1000*15);
    setInterval(() => this.getStockLastestPrice(), 1000*15);
  }

}
