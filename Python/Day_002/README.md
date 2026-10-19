# Day 2: Customer Data Cleaning and Missing Value Treatment

## 1. Objective

The objective of this exercise is to identify and handle
missing values in a customer dataset using Python and Pandas.

The cleaned dataset is then prepared for a potential
machine learning classification task.

## 2. Problem Statement

A business maintains customer information containing:

- Age
- Income
- Experience
- City
- Purchase status

Some records contain missing values.

The task is to:

1. Create a sample customer dataset.
2. Identify missing values in each column.
3. Calculate the percentage of missing values.
4. Fill missing numerical values using the median.
5. Fill missing categorical values using the mode.
6. Verify that missing values have been handled.
7. Separate the input features and target variable.

## 3. Tools and Libraries

- Python
- Pandas
- NumPy

## 4. Dataset Description

The dataset contains 10 customer records.

| Column | Description | Data Type |
|---|---|---|
| age | Customer age | Numerical |
| income | Customer income | Numerical |
| experience | Years of work experience | Numerical |
| city | Customer city | Categorical |
| purchased | Purchase status (0 or 1) | Binary |

### Target Variable

The `purchased` column represents the target variable.

- 0: Customer did not purchase.
- 1: Customer purchased.

These labels are defined for this practice dataset.

## 5. Approach

### Step 1: Create the Dataset

A Python dictionary is created with customer information.
Pandas converts the dictionary into a DataFrame.

NumPy's `np.nan` represents missing values.

### Step 2: Identify Missing Values

The `isnull()` and `sum()` methods identify the number
of missing values in each column.

### Step 3: Calculate Missing Value Percentage

The `isnull().mean() * 100` expression calculates the
percentage of missing values in each column.

### Step 4: Handle Numerical Missing Values

Missing values in `age`, `income`, and `experience`
are replaced with their respective column medians.

The median is less sensitive to extreme values than
the mean.

### Step 5: Handle Categorical Missing Values

Missing values in `city` are replaced with the most
frequently occurring city, calculated using `mode()`.

### Step 6: Verify the Cleaning Process

The missing-value count is calculated again to verify
whether any missing values remain.

### Step 7: Separate Features and Target

The input features are stored in `X`.

The target variable is stored in `y`.

This prepares the data for a potential classification model.

## 6. Python Concepts Practiced

- Dictionaries
- Pandas DataFrames
- NumPy missing values
- `isnull()`
- `sum()`
- `mean()`
- `median()`
- `mode()`
- `fillna()`
- `drop()`
- `axis`
- `for` loops
- Feature and target separation

## 7. Expected Results

The original dataset contains missing values in four columns:

| Column | Missing Values |
|---|---:|
| age | 2 |
| income | 2 |
| experience | 2 |
| city | 1 |
| purchased | 0 |

After applying the imputation methods, the dataset should
contain no missing values.

The cleaned dataset will contain:

- 10 customer records
- 4 input features
- 1 target variable

## 8. Business Insights

- Missing-value analysis helps identify data quality issues.
- Median imputation provides a simple approach for numerical
  missing values.
- Mode imputation provides a simple approach for categorical
  missing values.
- Separating features and target prepares the dataset for
  supervised machine learning.

## 9. How to Run

Install the required libraries:

```bash
pip install pandas numpy