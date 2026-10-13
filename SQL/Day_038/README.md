# Day 38 — SQL Interview Practice

## Topic
Detect Potential Duplicate Vendor Invoices

**Difficulty:** Intermediate–Advanced

**Business Domain:** Finance, Accounts Payable, and Data Quality

**Database:** Microsoft SQL Server

---

## 1. Problem Statement

A finance department needs to identify vendor invoices that may have been entered more than once.

However, invoice numbers may have inconsistent formatting.

For example:

- `INV-1001`
- `inv 1001`
- `INV1001`

These invoice numbers may represent the same invoice.

Write a SQL query to identify potential duplicate invoices using the following conditions:

1. The invoices belong to the same vendor.
2. Their normalized invoice numbers match.
3. Their invoice amounts are equal.
4. Their invoice dates are within 30 days.
5. Each invoice pair appears only once.

---

## 2. Business Objective

Identifying potential duplicate invoices helps organizations:

- Improve financial data quality.
- Reduce duplicate payment risks.
- Strengthen accounts payable controls.
- Support invoice reconciliation and auditing.

The query identifies potential duplicates, not confirmed fraud or duplicate payments.

---

## 3. Table Structure

Table name: `vendor_invoices`

| Column | Data Type | Description |
|---|---|---|
| invoice_id | INT | Unique invoice identifier |
| vendor_id | INT | Vendor identifier |
| vendor_name | VARCHAR(100) | Vendor name |
| invoice_number | VARCHAR(50) | Original invoice number |
| invoice_date | DATE | Invoice date |
| invoice_amount | DECIMAL(12,2) | Invoice amount |

The `solution.sql` file includes the table creation script and sample data.

---

## 4. Approach and Logic

### Step 1: Normalize invoice numbers

Use `LTRIM()` and `RTRIM()` to remove leading and trailing spaces.

Use `REPLACE()` to remove internal spaces and hyphens.

Use `UPPER()` to standardize letter casing.

### Step 2: Create a CTE

The `NormalizedInvoices` CTE calculates the normalized invoice number for every record.

### Step 3: Perform a self-join

Join the CTE to itself to compare invoices against other invoices.

### Step 4: Apply matching conditions

Compare invoices using:

- Vendor ID
- Normalized invoice number
- Invoice amount
- Invoice date difference

### Step 5: Prevent duplicate pairs

The condition `a.invoice_id < b.invoice_id` prevents the same pair from appearing twice in reverse order.

### Step 6: Apply the date condition

Use `DATEDIFF()` and `ABS()` to ensure the invoices are no more than 30 days apart.

---

## 5. SQL Concepts Practiced

- Common Table Expressions (CTEs)
- String normalization
- `UPPER()`
- `REPLACE()`
- `LTRIM()` and `RTRIM()`
- Self-joins
- `DATEDIFF()`
- `ABS()`
- Data quality validation
- Duplicate detection

---

## 6. Expected Output

The sample data should identify these potential duplicate pairs:

| Invoice ID 1 | Invoice ID 2 | Normalized Invoice | Amount | Days Apart |
|---:|---:|---|---:|---:|
| 1 | 2 | INV1001 | 1200.00 | 4 |
| 3 | 4 | INV1002 | 850.00 | 22 |
| 8 | 9 | INV1003 | 400.00 | 1 |

The query returns three invoice pairs.

---

## 7. Key Learnings

1. Text normalization can reveal matching identifiers hidden by formatting differences.
2. A self-join can compare records within the same table.
3. Multiple business conditions can improve duplicate detection.
4. A date window helps distinguish potentially related transactions.
5. Unique pair conditions prevent duplicate comparison results.

---

## 8. Limitations and Improvements

The query removes spaces and hyphens and converts invoice numbers to uppercase.

Other formatting differences may still exist.

Additional validation could consider:

- Vendor tax identification numbers
- Purchase order references
- Invoice currency
- Payment status
- Original invoice documents
- Vendor-specific invoice numbering rules

Matching records should be reviewed before being classified as confirmed duplicates.

---

## 9. Conclusion

This exercise demonstrates how SQL can support financial data quality checks by identifying potential duplicate vendor invoices.

The solution combines string normalization, CTEs, self-joins, and date comparisons to identify suspicious invoice pairs.

**Learning objective:** Develop practical SQL skills for financial data validation and duplicate detection.