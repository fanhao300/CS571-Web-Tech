import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor() {}

  title = 'Stock Search';

  ngOnInit() {
    localStorage.setItem('watchList', 'AMZN,NVDA,');
    let portfolio = [{
      ticker: "AMZN",
      quantity: 30,
      totalCost: 6255.75
    },{
      ticker: "NVDA",
      quantity: 55,
      totalCost: 30780.1
    }]

    localStorage.setItem('portfolio', JSON.stringify(portfolio));
    // localStorage.setItem('portfolio', "[]");
  }
}
