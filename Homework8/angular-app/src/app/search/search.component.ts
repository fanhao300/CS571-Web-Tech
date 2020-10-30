import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl} from '@angular/forms';

import { AppService } from '../app.service'
import { StockSearchResult } from '../dataFormat'

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {
  ticker = new FormControl('');
  searchResult: StockSearchResult[];
  changeCount: number = 0;
  
  constructor(
    private router: Router,
    private appService: AppService) {}

  getStockSearchResult(): void{
    this.appService.getStockSearchResult(this.ticker.value)
    .subscribe(searchResult => this.searchResult = searchResult);
  }
  
  btnClick() {
    this.router.navigateByUrl('/detail/' + this.ticker.value);
  };

  options: string[] = ['One', 'Two', 'Three'];

  ngOnInit(): void {
  }

}
