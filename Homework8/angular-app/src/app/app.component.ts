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
    // localStorage.setItem('portfolio', 'AMZN,NVDA');

  }
}
