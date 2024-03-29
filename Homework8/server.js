const express = require('express');
const app = express(),
      bodyParser = require("body-parser");
      port = 8080;

const tiingo_token = "7fa7d74973646b75de560ca7e7352e92300f4355";
const news_token = "09f4ee92d57b427eb75b437c69ce6ae5";

app.use(bodyParser.json());

//When develop, comment these lines.
//When develop, comment these lines.
//When develop, comment these lines.
//When develop, comment these lines.
app.use(express.static(process.cwd()+"/angular-app/dist/angular-app/"));

//Get company infomation
app.get('/api/company/:ticker', (req, res) => {
  let ticker=req.params.ticker;
  let request = require('request');
  let requestOptions = {
    'url': `https://api.tiingo.com/tiingo/daily/${ticker}?token=${tiingo_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body) {
      body = JSON.parse(body);
      if (body.detail == "Not found.")
        body.exist = 0;
      else 
        body.exist = 1;

      res.json(body);
    }
  );
});



// Get stock latest price 
app.get('/api/stock/latest/:ticker', (req, res) => {
  let ticker=req.params.ticker;
  let request = require('request');
  let requestOptions = {
    'url': `https://api.tiingo.com/iex/?tickers=${ticker}&token=${tiingo_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body) {
      body = JSON.parse(body);
      body = body[0];
      if (body){
        body.change = Number((body.last - body.prevClose).toFixed(2));
        body.changePer = Number((body.change * 100 / body.prevClose).toFixed(2));
        if (!body.mid) body.mid = "-"
        body.exist = 1;
      }
      else {
        body = { exist: 0}
      }
      res.json(body);
    }
  );
});

// Get stocks latest price 
app.get('/api/stocks/latest/:ticker', (req, res) => {
  let ticker=req.params.ticker;
  let request = require('request');
  let requestOptions = {
    'url': `https://api.tiingo.com/iex/?tickers=${ticker}&token=${tiingo_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body) {
      body = JSON.parse(body);
      for (i = 0; i < body.length; ++i){
        body[i].change = Number((body[i].last - body[i].prevClose).toFixed(2));
        body[i].changePer = Number((body[i].change * 100 / body[i].prevClose).toFixed(2));
        if (!body[i].mid) body[i].mid = "-"
        body[i].exist = 1;
      }
      body.sort((a,b) => {
        if (a.ticker > b.ticker) return 1;
        if (a.ticker < b.ticker) return -1;
        if (a.ticker == b.ticker) return 0;
      });
      res.json(body);
    }
  );
});


// Get stock latest day's price array. 
//The date is in an array. And the interval is 4 mins. 
app.get('/api/stock/latestday/:ticker', (req, res) => {
  let ticker = req.params.ticker;
  let request = require('request');
  let requestOptions = {
    'url': `https://api.tiingo.com/iex/?tickers=${ticker}&token=${tiingo_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body1) {
      body1 = JSON.parse(body1);
      body1 = body1[0];
      if (body1 && body1.hasOwnProperty('lastSaleTimestamp')
        && body1.lastSaleTimestamp != null){
        let ts = body1.lastSaleTimestamp.slice(0,10);
        let request2 = require('request');
        let requestOptions2 = {
          'url': `https://api.tiingo.com/iex/${ticker}/prices?startDate=${ts}&resampleFreq=4min&token=${tiingo_token}`,
          'headers': {
            'Content-Type': 'application/json'      
          }
        };
        request2(requestOptions2,
          function(error, response, body) {
            body = JSON.parse(body);
            res.json(body);
          }
        );
      }
      else {
        body1 = { exist: 0}
        res.json(body1);
      }
    }
  );
});

//Get 2 year stock price. The interval is 1 day.
app.get('/api/stock/historical/:ticker', (req, res) => {
  let ticker=req.params.ticker;
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
  // url = `https://api.tiingo.com/tiingo/daily/${ticker}/prices?startDate=${date}&resampleFreq=daily&token=${tiingo_token}`
  // res.send(url);
  let request = require('request');
  let requestOptions = {
    'url': `https://api.tiingo.com/tiingo/daily/${ticker}/prices?startDate=${date}&resampleFreq=daily&token=${tiingo_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body) {
      body = JSON.parse(body);
      res.json(body);
    }
  );
});



//Get news
app.get('/api/news/:ticker', (req, res) => {
  let ticker=req.params.ticker;
  let request = require('request');
  let requestOptions = {
    'url': `https://newsapi.org/v2/everything?q=${ticker}&apiKey=${news_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body) {
      body = JSON.parse(body);
      if (!body.hasOwnProperty("articles")){
        body = {
          exist: 0
        }
        res.json(body);
        return;
      }
      body = body.articles;
      let news_list = [];
      let cnt = 0;
      
      while (news_list.length < 20 && body.length > cnt){
        if (body[cnt] && 
          body[cnt].hasOwnProperty("urlToImage") &&
          body[cnt].hasOwnProperty("source") &&
          body[cnt].source.hasOwnProperty("name") &&
          body[cnt].hasOwnProperty("title") &&
          body[cnt].hasOwnProperty("description") &&
          body[cnt].hasOwnProperty("url") &&
          body[cnt].hasOwnProperty("publishedAt") &&
          body[cnt].urlToImage != null && body[cnt].source.name != null
          && body[cnt].title != null && body[cnt].description != null
          && body[cnt].url != null && body[cnt].publishedAt != null ){
            let news = {
              "urlToImage": body[cnt].urlToImage,
              "source": body[cnt].source.name,
              "title": body[cnt].title,
              "description": body[cnt].description,
              "url": body[cnt].url,
              "publishedAt": body[cnt].publishedAt
            }
            news_list.push(news);
        }
        cnt = cnt + 1;
      }
      res.json(news_list);
    }
  );
});


//For auto-complete
app.get('/api/autocomplete/:query', (req, res) => {
  let query=req.params.query;
  let request = require('request');
  let requestOptions = {
    'url': `https://api.tiingo.com/tiingo/utilities/search?query=${query}&token=${tiingo_token}`,
    'headers': {
      'Content-Type': 'application/json'      
    }
  };
  request(requestOptions,
    function(error, response, body) {
      body = JSON.parse(body);
      let retList = [];
      let cnt = 0;
      
      while (retList.length < 10 && body.length > cnt){
        if (body[cnt] && 
          body[cnt].hasOwnProperty("name") &&
          body[cnt].hasOwnProperty("ticker") &&
          body[cnt].name != null && body[cnt].ticker != null){
            let ret = {
              "name": body[cnt].name,
              "ticker": body[cnt].ticker,
            }
            retList.push(ret);
        }
        cnt = cnt + 1;
      }
      res.json(retList);
    }
  );
});

app.get('*', (req,res) => {
  //When develop, comment these lines.
  //When develop, comment these lines.
  res.sendFile(process.cwd()+"/angular-app/dist/angular-app/index.html")
});

app.listen(port, () => {
    console.log(`Server listening on the port::${port}`);
});