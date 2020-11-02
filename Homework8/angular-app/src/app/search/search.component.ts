import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl} from '@angular/forms';

import { AppService } from '../app.service'
import { StockSearchResult } from '../dataFormat'
import { Observable } from 'rxjs';
import { debounce, debounceTime, map, startWith} from 'rxjs/operators';
import { Recoverable } from 'repl';
import { stringify } from 'querystring';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {
  constructor(
    private router: Router,
    private appService: AppService) 
  {}

  ticker = new FormControl('');
  searchResult: StockSearchResult[];
  changeCount: number = 0;
  isInput: boolean = true;

  getStockSearchResult(ticker: string): void{
    if (ticker.length == 0) return;
    this.isInput = false;
    this.appService.getStockSearchResult(ticker)
    .subscribe(searchResult => this.searchResult = searchResult);
  }
  
  btnClick() {
    if (this.ticker.value != '')
      this.router.navigateByUrl('/detail/' + this.ticker.value);
  };

  // displayTicker(stock: StockSearchResult): string{
  //   return stock.name + " | " + stock.ticker;
  // }

  recover(ticker:string){
    this.searchResult = null;
    this.isInput = true;
    return ticker;
  }

  ngOnInit(): void {
    this.ticker.valueChanges.pipe(
      map((ticker)=> this.recover(ticker)),
      debounceTime(1000)
    ).subscribe(ticker =>this.getStockSearchResult(ticker));
      
  }

}
