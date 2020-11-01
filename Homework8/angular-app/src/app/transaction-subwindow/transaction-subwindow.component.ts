import { Component, OnInit, Input, Output, EventEmitter} from '@angular/core';
import { FormControl} from '@angular/forms';

import { Portfolio } from '../dataFormat';

@Component({
  selector: 'app-transaction-subwindow',
  templateUrl: './transaction-subwindow.component.html',
  styleUrls: ['./transaction-subwindow.component.css']
})
export class TransactionSubwindowComponent implements OnInit {
  @Input() ticker: string;
  @Input() name: string;
  @Input() currentPrice: number;
  @Input() totalNum: number;
  @Input() idString:string;
  @Input() isBuy:boolean;

  @Output() itemEvent = new EventEmitter<string>();

  public quantity = new FormControl('');
 
  
  constructor() { }

  buyBtn(ticker:string, quantity:number, cost:number):void {
    let portfolioString = localStorage.getItem("portfolio");
    let portfolio = JSON.parse(portfolioString);
    let target = portfolio.findIndex(item => item.ticker==ticker);
    if (target == -1){
      let item: Portfolio={
        ticker: ticker,
        totalCost: cost,
        name: name,
        quantity: quantity
      }
      portfolio.push(item);
    }
    else {
      portfolio[target].quantity += quantity;
      portfolio[target].totalCost += cost;
    }
    portfolioString = JSON.stringify(portfolio);
    localStorage.setItem("portfolio", portfolioString)

    this.itemEvent.emit("success");
  }

  sellBtn(ticker:string, quantity:number, cost:number):void{
    let portfolioString = localStorage.getItem("portfolio");
    let portfolio: Portfolio[] = JSON.parse(portfolioString);
    let target = portfolio.findIndex(item => item.ticker==ticker);
    portfolio[target].quantity -= quantity;
    portfolio[target].totalCost -= cost;
    portfolioString = JSON.stringify(portfolio);
    localStorage.setItem("portfolio", portfolioString)

    this.itemEvent.emit("success");
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
    this.currentPrice = Number(this.currentPrice);
    this.totalNum = Number(this.totalNum);
  }

}
