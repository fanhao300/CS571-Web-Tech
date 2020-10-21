const express = require('express');
const app = express(),
      bodyParser = require("body-parser");
      port = 8080;

const stock = [{
  "title": "Pair",
  "ticker": "aapl"
}]

app.use(bodyParser.json());

//For build. When develop, comment these lines.
//For build. When develop, comment these lines.
// app.use(express.static(process.cwd()+"/angular-app/dist/angular-app/"));
//For build. When develop, comment these lines.
//For build. When develop, comment these lines.

app.get('/api/stock', (req, res) => {
  res.json(stock);
});

app.get('/', (req,res) => {
    //For build. When develop, comment these lines.
    //For build. When develop, comment these lines.
    // res.sendFile(process.cwd()+"/angular-app/dist/angular-app/index.html")
    //For build. When develop, comment these lines.
    //For build. When develop, comment these lines.
});

app.listen(port, () => {
    console.log(`Server listening on the port::${port}`);
});

// app.post('/api/user', (req, res) => {
//   const user = req.body.user;
//   users.push(user);
//   res.json("user addedd");
// });
