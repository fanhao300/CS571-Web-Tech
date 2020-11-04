import { Component, OnInit, Input, OnChanges, SimpleChanges} from '@angular/core';

import { StockInf, StockLatestPrice, StockGraphPrice} from '../dataFormat';
import * as Highcharts from "highcharts/highstock";

@Component({
  selector: 'app-stock-detail-summary',
  templateUrl: './stock-detail-summary.component.html',
  styleUrls: ['./stock-detail-summary.component.css']
})
export class StockDetailSummaryComponent implements OnInit, OnChanges{

  @Input() stockInf: StockInf;
  @Input() stockLatestPrice: StockLatestPrice;
  @Input() stockSummaryPrice: StockGraphPrice[];
  @Input() updateParentFlag: boolean;

  updateFlag: boolean = false;

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

  numberWithCommas(x, isDecimal: boolean) {
    // If x cannot convert to number
    if (isNaN(Number(x))) return x;
    else {
      x = Number(x);
    }

    //convert x
    let parts: string[];
    if (isDecimal){
      parts = x.toFixed(2).split(".");
    }
    else {
      parts = x.toString().split(".");
    }
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
  }

  toString(a): string{
    return JSON.stringify(a);
  }

  updateHighchart(): void{
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
    
    if (this.chartOptions && this.chartOptions.series[0].type === 'area' ){
      this.chartOptions.series[0].color = color;
      this.chartOptions.series[0].data = close_list;
    }
    this.updateParentFlag = false;
    this.updateFlag = true;
  }

  ngOnChanges(changes: SimpleChanges) {
    for (const propName in changes) {
      if (changes.hasOwnProperty(propName)) {
        switch (propName) {
          case 'updateParentFlag': {
            if (this.updateParentFlag){
              this.updateHighchart();
            }
          }
        }
      }
    }
  }


  ngOnInit(): void {
    this.configHighchart();
  }
}
