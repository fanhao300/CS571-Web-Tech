import { Component, OnInit, Input} from '@angular/core';

import { News } from '../dataFormat';
@Component({
  selector: 'app-stock-detail-news',
  templateUrl: './stock-detail-news.component.html',
  styleUrls: ['./stock-detail-news.component.css']
})
export class StockDetailNewsComponent implements OnInit {

  @Input() newsList: News[];

  news: News;

  constructor() { }

  ngOnInit(): void {
    this.news = this.newsList[0];
  }

}
