# Day 40 — SQL Interview Practice

## Topic: Identify Frequently Purchased Product Pairs

**Difficulty:** Intermediate–Advanced  
**Database:** Microsoft SQL Server  
**Business Domain:** E-commerce and Retail Analytics

## 1. Problem Statement

An e-commerce company wants to identify products that customers frequently purchase together.

Using the `order_items` table, find all unique product pairs that appear together in at least three distinct orders.

## 2. Business Objective

Identify frequently purchased product combinations to support:

- Product bundling strategies
- Cross-selling recommendations
- Marketing campaigns
- Product placement decisions
- Market basket analysis

## 3. Table Structure

The solution uses the following table:

`order_items`

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| product_id | Product identifier |
| product_name | Product name |
| quantity | Quantity purchased |

The composite primary key is `(order_id, product_id)`.

## 4. SQL Concepts Practiced

- Common Table Expressions (CTEs)
- INNER JOIN
- Self-join
- Aggregate functions
- COUNT(DISTINCT)
- GROUP BY
- HAVING and filtering logic
- ORDER BY
- Product pair identification

## 5. Approach

1. Join the `order_items` table to itself using `order_id`.
2. Use `a.product_id < b.product_id` to avoid pairing a product with itself and eliminate reversed duplicate pairs.
3. Group the product pairs and count distinct orders.
4. Retain pairs appearing in at least three orders.
5. Sort the results by purchase frequency in descending order.

## 6. Expected Result

| Product 1 | Product 2 | Orders Together |
|---|---|---:|
| Laptop | Wireless Mouse | 4 |
| Wireless Mouse | Keyboard | 3 |

## 7. Conclusion

This exercise demonstrates how SQL self-joins and aggregation can identify frequently purchased product combinations.

The same approach can support cross-selling, product bundling, and introductory market basket analysis.

## 8. How to Run

1. Open `solution.sql` in SQL Server Management Studio (SSMS).
2. Select the appropriate database.
3. Execute the complete script.
4. Review the resulting product pairs.

The script includes the sample table, sample data, and solution query.

---

**Practice Series:** Daily Data Analytics Practice  
**Day:** 40  
**Technology:** SQL Server