import { Component, OnInit, Input} from '@angular/core';

import { StockGraphPrice} from '../dataFormat';
import * as Highcharts from "highcharts/highstock";

@Component({
    selector: 'app-stock-detail-charts',
    templateUrl: './stock-detail-charts.component.html',
    styleUrls: ['./stock-detail-charts.component.css']
})    
export class StockDetailChartsComponent implements OnInit {

    @Input() stockHistoricalPrice:StockGraphPrice[];
    @Input() stockTicker: string;

    constructor() { }
  
    Highcharts: typeof Highcharts = Highcharts;
    chartOptions: Highcharts.Options;

    configHighchart(): void{
        let ohlc = [];
        let volume = [];

        for (let i = 0; i < this.stockHistoricalPrice.length; i++) {
            let date = this.stockHistoricalPrice[i].date;
            let time = new Date(date);
            let ts = time.getTime()

            ohlc.push([ts,
                this.stockHistoricalPrice[i].open,
                this.stockHistoricalPrice[i].high,
                this.stockHistoricalPrice[i].low,
                this.stockHistoricalPrice[i].close
            ]);

            volume.push([ts,this.stockHistoricalPrice[i].volume]);
        }

        this.chartOptions = {
            chart: {
                width: null,
                height: null
            },
            rangeSelector: { selected: 2 },
            title: { text: this.stockTicker + ' Historical'},
            subtitle: { text: 'With SMA and Volume by Price technical indicators'},

            yAxis: [{
                startOnTick: false,
                endOnTick: false,
                labels: {
                    align: 'right',
                    x: -3
                },
                title: { text: 'OHLC' },
                height: '60%',
                lineWidth: 2,
                resize: {
                    enabled: true
                }
            }, {
                labels: {
                    align: 'right',
                    x: -3
                },
                title: { text: 'Volume' },
                top: '65%',
                height: '35%',
                offset: 0,
                lineWidth: 2
            }],

            tooltip: { split: true },

            series: [{
                type: 'candlestick',
                name: this.stockTicker,
                id: this.stockTicker,
                zIndex: 2,
                data: ohlc
            }, {
                type: 'column',
                name: 'Volume',
                id: 'volume',
                data: volume,
                yAxis: 1
            }, {
                type: 'vbp',
                linkedTo: this.stockTicker,
                params: { volumeSeriesID: 'volume' },
                dataLabels: { enabled: false },
                zoneLines: { enabled: false }
            }, {
                type: 'sma',
                linkedTo: this.stockTicker,
                zIndex: 1,
                marker: { enabled: false }
            }]
        };
    }

    chartCallback: Highcharts.ChartCallbackFunction = function (chart): void {
        setInterval(() => {
         chart.reflow();
        },0);
    };

    ngOnInit(): void {
        let indicators = require('highcharts/indicators/indicators');
        indicators(Highcharts);
        let vbp = require('highcharts/indicators/volume-by-price');
        vbp(Highcharts);

        this.configHighchart();
    }
}
