import { Injectable } from '@angular/core';
import { HttpClient,HttpHeaders } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import {StockInf, StockLatestPrice, StockGraphPrice, News} from './dataFormat'

@Injectable({
  providedIn: 'root'
})
export class AppService {

  constructor(
    private http: HttpClient) { }

  rootUrl = '/api';
  stockUrl = this.rootUrl + '/company/';
  latestPriceUrl = this.rootUrl + '/stock/latest/';
  summaryPriceUrl = this.rootUrl + '/stock/latestday/';
  historicalPriceUrl = this.rootUrl + '/stock/historical/'

  newsUrl = this.rootUrl + '/news/';

  getStockInf(ticker: string): Observable<StockInf>{
    return this.http.get<StockInf>(this.stockUrl + ticker);
  }

  getStockLastestPrice(ticker: string): Observable<StockLatestPrice>{
    return this.http.get<StockLatestPrice>(this.latestPriceUrl + ticker);
  }

  getStockSummaryPrice(ticker: string): Observable<StockGraphPrice[]>{
    return this.http.get<StockGraphPrice[]>(this.summaryPriceUrl + ticker);
  }

  getStockHistoricalPrice(ticker: string): Observable<StockGraphPrice[]>{
    return this.http.get<StockGraphPrice[]>(this.historicalPriceUrl + ticker);
  }

  getNews(ticker: string): Observable<News[]>{
    return this.http.get<News[]>(this.newsUrl + ticker);
  }
}