import { Component, OnInit, Input} from '@angular/core';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import { News } from '../dataFormat';

@Component({
  selector: 'app-stock-detail-news-subwindow',
  templateUrl: './stock-detail-news-subwindow.component.html',
  styleUrls: ['./stock-detail-news-subwindow.component.css']
})
export class StockDetailNewsSubwindowComponent implements OnInit {

  @Input() news: News;

  constructor(public activeModal: NgbActiveModal) { }

  getNewsDateByTime(time: string): string{
    let date = new Date(time);
    let options = {year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
  }

  encode(uri: string){
      return encodeURI(uri);
  }

  ngOnInit(): void {
  }

}
