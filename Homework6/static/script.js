function cancelSubmit(){
    return false;
}

async function getInformation() {
    // Get company ticker from user's input field
    // $('#submit_handle').click();
    document.getElementById("submit_handle").click();
    let ticker = document.getElementById("stock").value;
    if (ticker.length ==  0) return;
    alert(ticker);

    // Get company indormation from url
    // let url = "http://pythonappenv-env.eba-irrrehak.us-east-1.elasticbeanstalk.com/api/stock?stock=" + ticker.toUpperCase();
    let url = "http://127.0.0.1:5000/api/stock?stock=" + ticker.toUpperCase();
    let response = await fetch(url);
    if (! response.ok) return;
    let json = await response.json();
    if ("name" in json.info){
        //TODO
        
        alert(json.info.name);
    }
    else {
        //TODO
        
        alert("Undefined");
    }
}