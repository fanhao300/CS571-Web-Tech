async function getInformation(ticker) {
    let date = new Date();
    date.setFullYear(date.getFullYear()-2);
    y = date.getFullYear();
    m = date.getMonth() + 1;
    if (m < 10) {
        m = '0' + m;
    }
    d = date.getDate();
    if (d < 10) {
        d = '0' + d;
    }
    date = y + "-" + m + "-" + d;

    const tiingo_token = "7fa7d74973646b75de560ca7e7352e92300f4355";

    let url = `https://api.tiingo.com/tiingo/daily/${ticker}/prices?startDate=${date}&resampleFreq=daily&token=${tiingo_token}`
    let response = await fetch(url);
    if (! response.ok) return;
    let json = await response.json();

    let ohlc = [];
    let volume = [];

    for (let i = 0; i < json.length; i++){
        let date = json[i].date;
        let time = new Date(date);
        let ts = time.getTime();

        ohlc.push([ts,
            json[i].open,
            json[i].high,
            json[i].low,
            json[i].close
        ]);

        volume.push([ts,json[i].volume]);
    }

    Highcharts.stockChart('container', {
        rangeSelector: { selected: 0},
        yAxis: [{
            startOnTick: false,
            endOnTick: false,
            labels: {
                align: 'right',
                x: -3
            },
            title: {
                text: 'OHLC'
            },
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
            title: {
                text: 'Volume'
            },
            top: '65%',
            height: '35%',
            offset: 0,
            lineWidth: 2
        }],

        tooltip: {
            split: true
        },

        // plotOptions: {
        //     series: {
        //         dataGrouping: {
        //             units: groupingUnits
        //         }
        //     }
        // },

        series: [{
            type: 'candlestick',
            name: 'AAPL',
            id: 'aapl',
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
            linkedTo: 'aapl',
            params: {
                volumeSeriesID: 'volume'
            },
            dataLabels: {
                enabled: false
            },
            zoneLines: {
                enabled: false
            }
        }, {
            type: 'sma',
            linkedTo: 'aapl',
            zIndex: 1,
            marker: {
                enabled: false
            }
        }]
    });
}


const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
let ticker = urlParams.get('ticker');
console.log(ticker);
getInformation(ticker);
