# Day 1: Customer Spending Analysis Using Python

## Objective

Analyze customer transactions to calculate total spending
for each customer and visualize the results.

## Problem Statement

A business has transaction data containing customer IDs,
products, quantities, and prices.

The objective is to:
1. Create a transaction DataFrame.
2. Calculate the total amount for each transaction.
3. Calculate total spending for each customer.
4. Sort customers by total spending.
5. Identify the top five customers.
6. Visualize customer spending using a bar chart.

## Tools and Libraries

- Python
- Pandas
- Matplotlib

## Approach

1. Create sample transaction data.
2. Convert the data into a Pandas DataFrame.
3. Calculate transaction amount using quantity × price.
4. Group transactions by customer ID.
5. Calculate total spending for each customer.
6. Sort customers in descending order of spending.
7. Select the top five customers.
8. Create a bar chart to visualize the results.

## Python Concepts Practiced

- Dictionaries
- Pandas DataFrames
- Creating calculated columns
- groupby()
- sum()
- reset_index()
- sort_values()
- head()
- Matplotlib bar charts

## Business Insights

- Customer 101 has the highest total spending.
- Customer 103 is the second-highest-spending customer.
- Customer 104 ranks third in total spending.
- A business can use this analysis to identify high-value
  customers and support customer retention strategies.

## How to Run

Install the required libraries:

pip install pandas matplotlib

Run the program:

python solution.py

## Files

- solution.py: Complete Python program.

## Conclusion

This exercise demonstrates how Python can be used to
aggregate transaction data, rank customers by spending,
and visualize business performance.