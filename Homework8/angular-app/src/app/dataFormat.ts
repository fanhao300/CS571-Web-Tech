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
    mid: number;
    volume: number;
    bidSize: number;
    bidPrice: number;
    askSize: number;
    askPrice: number;
    change: number;
    changePer: number;
    exist: number;
}