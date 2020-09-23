var json = {};

function cancelSubmit(){
    return false;
}

function set_button_active(lable){
    let button_list = document.getElementById("navigation").firstChild.children;
    for (let i = 0; i < button_list.length; i++) {
        button_list[i].classList.remove("active");
    }
    let stock_button = button_list[lable];
    stock_button.classList.add("active");
}

async function getInformation() {
    // Get company ticker from user's input field
    // $('#submit_handle').click();
    document.getElementById("submit_handle").click();
    let ticker = document.getElementById("stock").value;
    if (ticker.length ==  0) return;

    // Get company indormation from url
    let url = "http://pythonappenv-env.eba-irrrehak.us-east-1.elasticbeanstalk.com/api/stock?stock=" + ticker.toUpperCase();
    // let url = "http://127.0.0.1:5000/api/stock?stock=" + ticker.toUpperCase();
    let response = await fetch(url);
    if (! response.ok) return;
    json = await response.json();

    clearInfo();

    if ("name" in json.info){
        let navigation_div = document.getElementById("navigation");
        navigation_div.innerHTML = 
        '<div class="navigation"> \
                <button class="active left" onclick="showOutlook()">Company OutLook</button> \
                <button onclick="showStock()">Stock Summary</button> \
                <button onclick="showTrend()">Charts</button> \
                <button onclick="showNews()">Latest News</button> \
        </div>';
        showOutlook();
    }
    else {
        let error_div = document.getElementById("error_message");
        error_div.innerHTML = 
        '<h3 class="text" style="text-align: center; padding-top: 30px;"> \
            Error: No record has been found, please enter a valid symbol. \
        </h3>';
    }
}

function clearInfo(){
    let navigation_div = document.getElementById("navigation");
    navigation_div.innerHTML = "";
    let info_div = document.getElementById("info");
    info_div.innerHTML = "";
    let error_div = document.getElementById("error_message");
    error_div.innerHTML = "";
}

function showOutlook(){
    set_button_active(0);

    outlook = json.info;
    let info_div = document.getElementById("info");
    info_div.innerHTML =
        '<table class="company_outlook text" style="width:100%;"> \
            <tr> \
                <th> Company Name</th> \
                <td> ' + outlook.name + '</td> \
            </tr> \
            <tr> \
                <th> Stock Ticker Symbol</th> \
                <td> ' + outlook.ticker + '</td> \
            </tr> \
            <tr> \
                <th> Stock Exchange Code</th> \
                <td> ' + outlook.exchangeCode + ' </td> \
            </tr> \
            <tr> \
                <th> Company Start Date</th> \
                <td> ' + outlook.startDate + ' </td> \
            </tr> \
            <tr> \
                <th> Description</th> \
                <td id="description"> ' + outlook.description + '</td>\
            </tr> \
        </table>';

}


function showStock(){
    set_button_active(1);
    
    stock = json.ticker;
    let url="";
    if (stock.change > 0)  
        url ='<img class="arrow_img" src="https://csci571.com/hw/hw6/images/GreenArrowUp.jpg">';
    else if (stock.change < 0)  
        url ='<img class="arrow_img" src="https://csci571.com/hw/hw6/images/RedArrowDown.jpg">';

    // alert(stock.);
    let info_div = document.getElementById("info");
    info_div.innerHTML = 
        '<table class="company_outlook text" style="width:100%;"> \
            <tr> <th> Stock Ticker Symbol</th> <td>' + stock.ticker + '</td> </tr> \
            <tr> <th> Trading Day</th> <td>' + stock.timestamp + '</td> </tr> \
            <tr> <th> Previous Closing Price</th> <td>' + stock.prevClose + '</td> </tr> \
            <tr> <th> Opening Price</th> <td>' + stock.open + '</td> </tr> \
            <tr> <th> High Price</th> <td>' + stock.high + '</td> </tr> \
            <tr> <th> Low Price</th> <td>' + stock.low + '</td> </tr> \
            <tr> <th> Last Price</th> <td>' + stock.last + '</td> </tr> \
            <tr> <th> Change</th> <td>' + stock.change + url + ' </td> </tr> \
            <tr> <th> Change Percent</th> <td> ' + stock.changePercent + '%' + url + ' </td> </tr> \
            <tr> <th> Number of Shares Traded</th> <td>' + stock.volume + ' </td> </tr> \
        </table>';

}


function showTrend(){
    set_button_active(2);

    stock = json.tocker;
    let info_div = document.getElementById("info");
    info_div.innerHTML = "";

}

function showNews(){
    set_button_active(3);

    news_list = json.news;
    let info_div = document.getElementById("info");
    info_div.innerHTML = "";

    for (let i = 0; i < news_list.length; i++){
        let date = news_list[i].publishedAt;
        date = date.substring(5,7) + '/' + date.substring(8) + '/' + date.substring(0,4);
        info_div.innerHTML += 
            '<div class="news_container"> \
                <div style="height: 120px; width: 134px; float: left;"> \
                    <img src="' + news_list[i].urlToImage + '" class="news_img"> \
                </div> \
                <div class="text" style="height: 120px; width: 1060px; float: left; padding-top: 10px; font-size:2.4ex;"> \
                    <b>' + news_list[i].title + '</b></br> \
                    Published Date: ' + date + '</br> \
                    <a target="_blank" href="' + news_list[i].url + '">See Original Post</a>\
                </div>\
            </div>';
    }

}