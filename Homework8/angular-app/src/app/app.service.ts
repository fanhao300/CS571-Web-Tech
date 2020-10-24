import { Injectable } from '@angular/core';
import { HttpClient,HttpHeaders } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import {StockInf, StockLatestPrice} from './dataFormat'

@Injectable({
  providedIn: 'root'
})
export class AppService {

  constructor(
    private http: HttpClient) { }

  rootUrl = '/api';
  stockUrl = this.rootUrl + '/company/'
  latestPriceUrl = this.rootUrl + '/stock/latest/'

  getStockInf(ticker: string): Observable<StockInf>{
    return this.http.get<StockInf>(this.stockUrl + ticker);
  }

  getStockLastestPrice(ticker: string): Observable<StockLatestPrice>{
    return this.http.get<StockLatestPrice>(this.latestPriceUrl + ticker);
  }


}