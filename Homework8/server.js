const express = require('express');
const app = express(),
      bodyParser = require("body-parser");
      port = 8080;

const tiingo_token = "7fa7d74973646b75de560ca7e7352e92300f4355";


app.use(bodyParser.json());

//When develop, comment these lines.
//When develop, comment these lines.
//When develop, comment these lines.
//When develop, comment these lines.
// app.use(express.static(process.cwd()+"/angular-app/dist/angular-app/"));


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



// Get stock infomation
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
        body.exist = 1;
        body.bidPrice = 1;
      }
      else {
        body = { exist: 0}
      }
      res.json(body);
    }
  );
});



app.get('/', (req,res) => {
  //When develop, comment these lines.
  //When develop, comment these lines.
  res.send('hello world');
  // res.sendFile(process.cwd()+"/angular-app/dist/angular-app/index.html")
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
