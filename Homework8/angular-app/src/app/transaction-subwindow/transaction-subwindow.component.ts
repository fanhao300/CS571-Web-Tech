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

  ngOnInit(): void {
  }

}
