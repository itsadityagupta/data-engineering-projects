DROP SCHEMA IF EXISTS stocks;
CREATE SCHEMA stocks;

CREATE TYPE locale AS ENUM ('us', 'global');

DROP TABLE IF EXISTS stocks.ticker_types;
CREATE TABLE stocks.ticker_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    description TEXT NOT NULL,
    locale locale NOT NULL,
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL
);

DROP TABLE IF EXISTS stocks.exchanges;
CREATE TABLE stocks.exchanges (
    id SERIAL PRIMARY KEY,
    exchange_id INTEGER NOT NULL,
    mic TEXT NOT NULL,
    operating_mic TEXT NOT NULL,
    name TEXT NOT NULL,
    participant_id TEXT NOT NULL,
    website_url TEXT NOT NULL,
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL
);

DROP TABLE IF EXISTS stocks.tickers;
CREATE TABLE stocks.tickers (
    id SERIAL PRIMARY KEY,
    ticker TEXT NOT NULL,
    name TEXT NOT NULL,
    primary_exchange INTEGER NOT NULL,
    ticker_type INTEGER NOT NULL,
    cik TEXT NOT NULL,
    active BOOLEAN NOT NULL,
    currency VARCHAR(50) NOT NULL,
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL,
    FOREIGN KEY(primary_exchange) REFERENCES stocks.exchanges(id),
    FOREIGN KEY(ticker_type) REFERENCES stocks.ticker_types(id)
);

DROP TABLE IF EXISTS stocks.trades;
CREATE TABLE stocks.trades (
    id SERIAL PRIMARY KEY,
    ticker_id INTEGER NOT NULL,
    trade_at DATE NOT NULL,
    high NUMERIC NOT NULL,
    low NUMERIC NOT NULL,
    open NUMERIC NOT NULL,
    close NUMERIC NOT NULL,
    afterhours NUMERIC NOT NULL,
    premarket NUMERIC NOT NULL,
    volume INTEGER NOT NULL,
    FOREIGN KEY(ticker_id) REFERENCES stocks.tickers(id)
);