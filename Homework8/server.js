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


// Get stock latest day's price array. 
//The date is in an array. And the interval is 15 seconds. 
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
      if (body1){
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
      body = body.articles;
      let news_list = [];
      let cnt = 0;
      while (news_list.length < 20){
        if (body[cnt].urlToImage && body[cnt].source.name 
          && body[cnt].title && body[cnt].description 
          && body[cnt].url && body[cnt].publishedAt ){
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



app.get('/', (req,res) => {
  //When develop, comment these lines.
  //When develop, comment these lines.
  res.send('hello world');
  res.sendFile(process.cwd()+"/angular-app/dist/angular-app/index.html")
});

// app.get('*', routes.index);

app.listen(port, () => {
    console.log(`Server listening on the port::${port}`);
});

// app.post('/api/user', (req, res) => {
//   const user = req.body.user;
//   users.push(user);
//   res.json("user addedd");
// });
