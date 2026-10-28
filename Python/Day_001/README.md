# Day 1: Personal Expense Analyzer Using Core Python

## Project Overview

The Personal Expense Analyzer is a beginner-level Python project that processes expense transactions and generates a financial summary.

The project demonstrates how core Python programming concepts can be used to solve a practical data analysis problem without external libraries.

## Business Problem

Individuals often record expenses but do not calculate total spending, category-wise expenditure, or remaining budget.

This project automates those calculations and produces a simple financial report.

## Objectives

* Calculate total expenditure.
* Calculate the average transaction amount.
* Summarize spending by category.
* Identify the largest transaction.
* Calculate the remaining budget.
* Detect whether spending exceeds the budget.
* Calculate the percentage contribution of each category.

## Technologies Used

* Python 3
* VS Code
* Git
* GitHub

No external Python packages are required.

## Project Structure

```text
Python/
└── Day_001/
    ├── solution.py
    └── README.md
```

## Dataset

The project uses a small, manually created dataset containing ten expense transactions.

Each transaction contains:

* `category`: Expense category.
* `amount`: Transaction amount in Indian rupees.

The dataset is included directly in the Python program.

## Methodology

### 1. Data Storage

Transactions are represented using a list of dictionaries.

### 2. Total Expenditure

A loop iterates through the transactions and calculates the sum of all expense amounts.

### 3. Average Transaction

Total expenditure is divided by the number of transactions.

### 4. Category-wise Analysis

A dictionary stores the accumulated expenditure for each category.

### 5. Largest Transaction

A loop compares transaction amounts and identifies the largest transaction.

### 6. Budget Analysis

Total expenditure is compared against the predefined monthly budget.

### 7. Reporting

The program prints a formatted financial summary in the terminal.

## Key Results

Using the original sample dataset:

| Metric                    |   Result |
| ------------------------- | -------: |
| Number of transactions    |       10 |
| Total expenditure         |   ₹5,150 |
| Average transaction       |     ₹515 |
| Largest transaction       |   ₹1,200 |
| Highest-spending category | Shopping |
| Remaining budget          |     ₹850 |

## Concepts Practiced

* Variables and data types
* Lists
* Dictionaries
* List indexing
* Dictionary key access
* `for` loops
* Conditional statements
* Arithmetic operations
* `len()`
* String formatting
* Accumulator patterns
* Basic data summarization

## How to Run

1. Install Python 3.
2. Open this project folder in VS Code.
3. Open the integrated terminal.
4. Run:

```bash
python solution.py
```

Alternatively, on Windows:

```bash
py solution.py
```

## Limitations

* Transactions are entered manually.
* The program does not read CSV or Excel files.
* It does not validate negative or incorrectly entered amounts.
* It does not store data permanently.
* It analyzes a single predefined budget.

## Future Improvements

* Read transactions from a CSV file.
* Add input validation.
* Analyze expenses using Pandas.
* Visualize category-wise spending.
* Export reports to CSV.
* Build an interactive dashboard.

## Learning Outcome

This project establishes a foundation in Python programming and demonstrates how loops, dictionaries, and conditional statements can solve a practical data analysis problem.
