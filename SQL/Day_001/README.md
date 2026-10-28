# SQL Day 1 — Retail Returns Analysis

## Project Overview

This project analyzes retail order data using Microsoft SQL Server. It identifies products with high return rates, calculates returned revenue, and categorizes products based on their return rates.

## Business Problem

Retail businesses need to identify products with unusually high return rates so they can investigate potential quality, packaging, compatibility, or product-description issues.

This project answers:

* How many orders were recorded for each product?
* How many orders were returned?
* What percentage of orders were returned?
* What is the value of returned orders?
* Which products should be investigated first?

## Tools Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* Git and GitHub

## Dataset

The project uses synthetic retail data with two tables.

### Products

Contains product IDs, names, categories, and unit prices.

### Orders

Contains order IDs, product IDs, order dates, amounts, and order statuses.

## SQL Skills Demonstrated

* SELECT statements
* INNER JOIN
* Aggregate functions
* Conditional aggregation
* CASE expressions
* GROUP BY
* ORDER BY
* Numeric type conversion
* Primary and foreign keys
* CHECK constraints

## Business Rules

Return rate = Returned orders / Total recorded orders × 100.

Returned revenue is calculated as the sum of recorded order amounts for returned orders. It is a proxy for the value associated with returns, not a calculation of actual net financial loss.

Products are categorized as follows:

* High Return Rate: 30% or above
* Medium Return Rate: 15% to below 30%
* Low Return Rate: Below 15%

## Key Findings

The synthetic dataset shows that:

* Wireless Mouse has a 50% return rate.
* Water Bottle has a 50% return rate.
* Mechanical Keyboard has a return rate of 33.33%.
* Laptop Stand has a return rate of 25%.
* Office Chair has no recorded returns.

The results demonstrate why return rates and returned revenue should be considered together.

## How to Run

1. Open SQL Server Management Studio.
2. Connect to a SQL Server instance.
3. Open `solution.sql`.
4. Execute the setup section to create the database and populate the tables.
5. Execute the analysis query.
6. Compare the results with the project findings.

**Note:** Rerunning the setup section drops and recreates the project tables. Use a separate database if you need to preserve additional data.

## Limitations

The dataset is synthetic and small. Real-world analysis should use a larger dataset and account for partial returns, refunds, cancellations, and the time period being analyzed.

## Learning Objective

Build a foundation in SQL aggregation and conditional logic while solving a practical retail analytics problem.
