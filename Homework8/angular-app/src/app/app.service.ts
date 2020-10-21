import { Injectable } from '@angular/core';
import { HttpClient,HttpHeaders } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import {Stock} from './dataFormat'

@Injectable({
  providedIn: 'root'
})
export class AppService {

  constructor(
    private http: HttpClient) { }

  rootUrl = '/api';
  stockUrl = this.rootUrl + '/stock'

  getStockInf(): Observable<Stock[]>{
    return this.http.get<Stock[]>(this.stockUrl);
  }


}