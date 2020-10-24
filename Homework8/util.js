class Util{
    token = "7fa7d74973646b75de560ca7e7352e92300f4355";

    async getCompanyInf(ticker) {
        let request = require('request');
        let requestOptions = {
            'url': `https://api.tiingo.com/tiingo/daily/${ticker}?token=${this.token}`,
            'headers': {
                'Content-Type': 'application/json'
            }
        };

        let ret="";
        request(requestOptions,
            function(error, response, body) {
                ret = body;


                // console.log(typeof(body));
                console.log(ret+'2');
            }
        );
        request.end()
        return ret;
    }
}


let a = new Util();
let ret = await a.getCompanyInf("aapl");
console.log(ret);


