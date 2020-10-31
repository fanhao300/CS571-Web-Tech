import { Component, OnInit, Input } from '@angular/core';

import { StockInf, StockLatestPrice, StockGraphPrice} from '../dataFormat';
import * as Highcharts from "highcharts/highstock";

@Component({
  selector: 'app-stock-detail-summary',
  templateUrl: './stock-detail-summary.component.html',
  styleUrls: ['./stock-detail-summary.component.css']
})
export class StockDetailSummaryComponent implements OnInit {

  @Input() stockInf: StockInf;
  @Input() stockLatestPrice: StockLatestPrice;
  @Input() stockSummaryPrice: StockGraphPrice[];

  constructor() { }

  isMarketOpen(time: string): boolean{
    let ret: boolean = false;
    let timeNow = new Date();
    let timeCheck = new Date(time);
    if (timeNow.getTime() - timeCheck.getTime() < 60 * 1000)
      ret = true;
    return ret;
  }

  Highcharts: typeof Highcharts = Highcharts;
  chartOptions: Highcharts.Options;

  configHighchart(): void{
    let close_list = [];
    for (let i = 0; i < this.stockSummaryPrice.length; ++i){
        let date = this.stockSummaryPrice[i].date;
        let time = new Date(date);
        let ts = time.getTime()
        close_list.push([ts, this.stockSummaryPrice[i].close]);
    }

    let color = '#ff0000';
    if (this.stockLatestPrice.change > 0){
      color = '#377E22';
    }
    else if (this.stockLatestPrice.change == 0){
      color = '#000000';
    }
      

    this.chartOptions = {
      title: {
        text: this.stockInf.ticker
      },
      yAxis: [
        { opposite: true}
      ],
      time: {
        useUTC: false
      },
      series: [{
        name: this.stockInf.ticker,
        data: close_list,
        type: 'area',
        tooltip: {valueDecimals: 2},
        threshold: null,
        color: color,
        fillOpacity: 0
      }],
      rangeSelector: {
        enabled: false
      },
      navigator: {
        series: {
          fillOpacity: 1
        }
      }
    };
  }

  chartCallback: Highcharts.ChartCallbackFunction = function (chart): void {
    setTimeout(() => {
     chart.reflow();
    },0);
  };


  ngOnInit(): void {
    this.configHighchart();
  }
}
