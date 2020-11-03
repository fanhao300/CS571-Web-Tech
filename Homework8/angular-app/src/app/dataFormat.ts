export interface StockInf{  
    ticker: string;
    name: string;
    description: string;
    exchangeCode: string;
    startDate: string;
    endDate: string;
    detail: string; 
    exist: number;  
}

export interface StockLatestPrice{
    ticker: string;
    timestamp: string;
    last: number;
    prevClose: number;
    open: number;
    high: number;
    low: number;
    mid: string;
    volume: number;
    bidSize: number;
    bidPrice: number;
    askSize: number;
    askPrice: number;
    change: number;
    changePer: number;
    exist: number;
}

export interface StockGraphPrice{
    date: string;
    close: number;
    high: number;
    low: number;
    open: number;
    volume: number;
}

export interface News{
    urlToImage: string;
    source: string;
    title: string;
    description: string;
    url: string,
    publishedAt: string;
}

export interface StockSearchResult{
    ticker: string;
    name: string;
}

export interface Portfolio{
    ticker: string;
    totalCost: number;
    quantity: number;
    name: string;
}

export interface WatchList{
    ticker: string;
    name: string;
}
