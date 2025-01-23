---Section 1:  Exploratory Data Analysis (EDA) 

-- 1.1 Get the Number of Records per Ticker
SELECT ticker, COUNT(*) AS records_counts FROM public.stock_prices
GROUP BY ticker;

--- 1.2 Calculate Summary Statistics
SELECT ticker,
        MIN(close) AS min_close_price,
        MAX(close) AS maximum_close_price,
        AVG(close) AS average_close_price,
        MIN(volume) AS minimum_volume,
        MAX(volume) AS maximum_volume
FROM stock_prices 
GROUP BY ticker;

--- 1.3 Find the Highest and Lowest Closing Prices with Dates
SELECT  ticker, date,
close AS closing_price
	FROM stock_prices
WHERE (ticker, close) IN 
(SELECT ticker, MAX(close) FROM stock_prices GROUP BY ticker)
OR (ticker, close) IN (SELECT ticker, MIN(close) FROM stock_prices GROUP BY ticker)
ORDER BY ticker, date;

--- Section 2: Comparative Analysis

--- 2.1 Comparing Percentage Growth Over Time
SELECT ticker,
ROUND(((MAX(close) - MIN(close)) / MIN(close)) * 100, 2) AS percentage_growth
FROM stock_prices 
GROUP BY ticker 
ORDER BY percentage_growth DESC;

--- 2.2 Identify the Most Volatile Stock     
SELECT ticker, 
ROUND(STDDEV(close), 2) AS price_volatility
FROM stock_prices
GROUP BY ticker 
ORDER BY price_volatility DESC;

--- Section 3: Advanced Queries

--- 3.1 Calculate 7-Day Moving Average
SELECT 
    ticker,
    date,
    close,
    ROUND(AVG(close) OVER (
        PARTITION BY ticker
        ORDER BY date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_7d
FROM stock_prices;

--- 3.2 Identifying Significant Price Changes (>5% in a Day)
WITH daily_changes AS (
    SELECT 
        ticker,
        date,
        ROUND(((close - LAG(close) OVER (PARTITION BY ticker ORDER BY date)) / LAG(close) OVER (PARTITION BY ticker ORDER BY date)) * 100, 2) AS daily_change_percentage
    FROM stock_prices
)
SELECT *
FROM daily_changes
WHERE ABS(daily_change_percentage) > 5;

--- 3.3 Correlation Between Tickers
SELECT 
    a.ticker AS ticker_1,
    b.ticker AS ticker_2,
    CORR(a.close, b.close) AS correlation
FROM stock_prices a
JOIN stock_prices b
ON a.date = b.date AND a.ticker < b.ticker
GROUP BY a.ticker, b.ticker
ORDER BY correlation DESC;

--- Query for portfolio 
    SELECT 
        date, 
        ticker, 
        close, 
        ROUND(AVG(close) OVER (PARTITION BY ticker ORDER BY date ROWS BETWEEN
		6 PRECEDING AND CURRENT ROW), 2) AS moving_avg_7d, 
        ROUND(((close - LAG(close) OVER (PARTITION BY ticker ORDER BY date)) / LAG(close) 
		OVER (PARTITION BY ticker ORDER BY date)) * 100, 2) 
		AS daily_change_percentage
    FROM stock_prices
    WHERE date BETWEEN '2020-01-01' AND '2023-12-31';

-- Note: The first row for each ticker has 
-- a null daily_change_percentage as there’s no previous price for comparison.

--- For Tableau Dashboard
WITH calculated_data AS (
    SELECT 
        date, 
        ticker, 
        close, 
        ROUND(AVG(close) OVER (PARTITION BY ticker ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS moving_avg_7d, 
        ROUND(((close - LAG(close) OVER (PARTITION BY ticker ORDER BY date)) / LAG(close) OVER (PARTITION BY ticker ORDER BY date)) * 100, 2) AS daily_change_percentage
    FROM stock_prices
    WHERE date BETWEEN '2020-01-01' AND '2023-12-31'
)
SELECT *
FROM calculated_data
WHERE daily_change_percentage IS NOT NULL;
