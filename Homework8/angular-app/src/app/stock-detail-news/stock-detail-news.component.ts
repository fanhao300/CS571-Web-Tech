import { Component, OnInit, Input} from '@angular/core';
import { NgbModal} from '@ng-bootstrap/ng-bootstrap';

import { News } from '../dataFormat';
import { StockDetailNewsSubwindowComponent } from '../stock-detail-news-subwindow/stock-detail-news-subwindow.component'

@Component({
  selector: 'app-stock-detail-news',
  templateUrl: './stock-detail-news.component.html',
  styleUrls: ['./stock-detail-news.component.css']
})
export class StockDetailNewsComponent implements OnInit {

  @Input() newsList: News[];

  constructor(private modalService: NgbModal) { }

  open(news: News): void{
    const modalRef = this.modalService.open(StockDetailNewsSubwindowComponent);
    modalRef.componentInstance.news = news;
  }

  ngOnInit(): void {
  }

}
