import requests
from datetime import date
from dateutil.relativedelta import *

TIINGO_TOKEN = "7fa7d74973646b75de560ca7e7352e92300f4355"
NEWS_TOKEN = "09f4ee92d57b427eb75b437c69ce6ae5"

def get_company_inf(company_ticker):
    headers = {
        'Content-Type': 'application/json'
    }
    url = "https://api.tiingo.com/tiingo/daily/" + company_ticker.lower() + "?token=" + TIINGO_TOKEN
    requestResponse = requests.get(url, headers=headers)
    
    inf = requestResponse.json()
    return inf


def get_company_stock(company_ticker):
    headers = {
        'Content-Type': 'application/json'
    }
    url = "https://api.tiingo.com/iex/?tickers=" + company_ticker.lower() + "&token=" + TIINGO_TOKEN
    requestResponse = requests.get(url, headers=headers)
    
    inf = requestResponse.json()[0]
    inf["last"] = 122.76
    inf["prevClose"] = 124.92
    inf["timestamp"] = inf["timestamp"][:10]
    inf["change"] = round(inf["last"] - inf["prevClose"], 2)
    inf["changePercent"] = round(inf["change"] / inf["prevClose"] * 100, 2)
    return inf


def get_company_news(company_ticker):
    headers = {
        'Content-Type': 'application/json'
    }
    url = "https://newsapi.org/v2/everything?q=" + company_ticker.lower() + "&apiKey=" + NEWS_TOKEN
    requestResponse = requests.get(url, headers=headers)
    
    news_list = requestResponse.json()["articles"]
    inf = []
    for news in news_list:

        if "urlToImage" in news.keys() and news["urlToImage"] != None and \
            "title" in news.keys() and news["title"] != None and \
            "publishedAt" in news.keys() and news["publishedAt"] != None and \
            "url" in news.keys() and news["url"] != None :
            dict = {
                "urlToImage": news["urlToImage"],
                "title": news["title"],
                "publishedAt": news["publishedAt"][:10],
                "url": news["url"],
            }
            inf.append(dict)
        if len(inf) == 5:
            break

    return inf


def get_company_stock_trend(company_ticker):
    headers = {
        'Content-Type': 'application/json'
    }

    start_date = date.today()+relativedelta(months=-6)
    url = "https://api.tiingo.com/iex/"+ company_ticker +"/prices?startDate=" + start_date.strftime("%Y-%m-%d") + "&resampleFreq=12hour&columns=close,volume&token=" + TIINGO_TOKEN
    requestResponse = requests.get(url, headers=headers)
    inf = requestResponse.json()
    return inf


########################## TEST ##########################
########################## TEST ##########################
########################## TEST ##########################
if __name__ == "__main__":
    inf1 = get_company_inf("BABA")
    print(inf1)
    inf2 = get_company_stock("AAPL")
    print(inf2)
    inf3 = get_company_news("AAPL")
    print(inf3)
    inf4 = get_company_stock_trend("AAPL")
    print(inf4)