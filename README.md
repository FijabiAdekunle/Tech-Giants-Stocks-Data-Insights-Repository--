# Tech Giants Stocks Data Insights Repository  
 This REPOSITORY offers a detailed analysis of the stock performance of Apple (AAPL), Microsoft (MSFT), and Google (GOOGL). 

 # Tech Industry Data Insights Repository  

Welcome to the **Tech Industry Data Insights Repository**! This repository is a collection of analytics projects focused on extracting, analyzing, and visualizing data from the Tech Giants Stock Market. Each project demonstrates a unique approach to answering real-world questions using data.

## Table of Contents
1. [Introduction](#introduction)
2. [Tech Giants Stock Analysis Dashboard](#tech-giants-stock-analysis-dashboard)
    - [Objective](#objective)
    - [Data Source](#data-source)
    - [Steps Followed](#steps-followed)
    - [SQL Queries](#sql-queries)
    - [Visualizations](#visualizations)
3. [How to Use This Repository](#how-to-use-this-repository)
4. [Contact](#contact)

---

## Introduction
This repository highlights the intersection of data analytics and the Tech Stock sector. The primary project, **Tech Giants Stock Analysis Dashboard**, focuses on stock market trends and performance metrics for leading tech companies like Apple (AAPL), Google (GOOGL), and Microsoft (MSFT). The project showcases data extraction, SQL-based processing, and visualization using Tableau.

---

## Tech Giants Stock Analysis Dashboard

### Objective
The goal of this project was to analyze stock performance trends, volume changes, and moving averages of major tech companies from 2020 to 2023. The dashboard allows users to interact with data filters and explore stock behavior over time.

### Data Source
- Data was sourced from **Yahoo Finance** using the `yfinance` Python library.  
- The dataset includes stock prices, trading volumes, and other financial metrics.

### Steps Followed
1. **Data Extraction**: Downloaded historical stock price data using Python's `yfinance` library.  
2. **Data Transformation**: Processed and cleaned the data using SQL for exploratory analysis.  
3. **Data Visualization**: Created an interactive Tableau dashboard to display insights.  

### SQL Queries
Key transformations were performed using SQL. For example:  

-- Calculate Year-to-Date (YTD) % Change
SELECT 
    ticker, 
    DATE_PART('year', date) AS year, 
    (CLOSE - FIRST_VALUE(CLOSE) OVER (PARTITION BY ticker, DATE_PART('year', date) ORDER BY date)) / 
    FIRST_VALUE(CLOSE) OVER (PARTITION BY ticker, DATE_PART('year', date) ORDER BY date) * 100 AS ytd_change
FROM stock_data;


**Note**: For a detailed breakdown of SQL queries, please refer to the tech_giants_analysis.sql file in this repository.

### Visualizations
The dashboard highlights key insights:

- Volume Trends Over Time: Tracks trading activity.
- Stock Performance Over Time: Shows stock price trends.
- Moving Average Trends: Highlights price stability using 50-day moving averages.
- Performance Comparison: A bar chart comparing the overall stock performance of AAPL, GOOGL, and MSFT.

You can view [ the Tableau Dashboard here](https://public.tableau.com/app/profile/fijabi.j.adekunle/viz/TechGiantsStockDashboard/TechGiantsStockDashboard)


### Contact
- Feel free to connect with me for feedback, collaboration, or queries:

- Portfolio: [My Data Analytics Portfolio](https://sites.google.com/view/fijabijadekunle/home)
- Email: dataexplorerconnects@gmail.com


