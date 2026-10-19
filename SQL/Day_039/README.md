# Day 39 — SQL Interview Practice

## Topic: Find Top Sales Representatives by Region

**Difficulty:** Intermediate–Advanced  
**Database:** Microsoft SQL Server  
**Business Domain:** Sales Analytics  
**Skills:** CTEs, JOINs, Aggregation, DENSE_RANK(), Window Functions

---

## 1. Problem Statement

A company wants to identify its highest-performing sales representatives in each region based on total revenue generated from completed deals.

The company maintains two tables:

- `sales_reps`: Contains sales representative details, including their ID, name, and region.
- `sales_deals`: Contains deal details, including deal amount, date, and status.

### Business Requirements

1. Consider only deals with a status of `Completed`.
2. Calculate the number of completed deals for each representative.
3. Calculate total revenue and average deal value.
4. Include only representatives with at least three completed deals.
5. Rank representatives by total revenue within each region.
6. Return all representatives who share the highest revenue rank in their region.

### Expected Outcome

The final result should identify the highest-revenue sales representatives in each region, including all representatives tied for first place.

---

## 2. Database Schema

### Table 1: sales_reps

| Column | Data Type | Description |
|---|---|---|
| rep_id | INT | Primary key |
| rep_name | VARCHAR(100) | Sales representative name |
| region | VARCHAR(50) | Sales region |

### Table 2: sales_deals

| Column | Data Type | Description |
|---|---|---|
| deal_id | INT | Primary key |
| rep_id | INT | Foreign key referencing sales_reps |
| deal_date | DATE | Deal date |
| deal_amount | DECIMAL(12,2) | Deal amount |
| deal_status | VARCHAR(20) | Deal status |

---

## 3. SQL Concepts Practiced

### Common Table Expressions (CTEs)
Used two CTEs to separate performance calculations from regional ranking.

### INNER JOIN
Combined sales representative details with their corresponding sales deals.

### Aggregate Functions
Used:
- `COUNT()` to count completed deals.
- `SUM()` to calculate total revenue.
- `AVG()` to calculate average deal value.

### GROUP BY
Grouped records by representative ID, name, and region to calculate individual performance metrics.

### HAVING
Filtered representatives to include only those with at least three completed deals.

### DENSE_RANK()
Ranked representatives by total revenue within each region.

### PARTITION BY
Restarted the ranking independently for each region.

---

## 4. Solution Approach

### Step 1: Calculate Representative Performance

The first CTE, `RepPerformance`, calculates:

- Number of completed deals.
- Total revenue.
- Average deal value.

Only completed deals are considered.

The `HAVING` clause excludes representatives with fewer than three completed deals.

### Step 2: Rank Representatives

The second CTE, `RankedReps`, applies:

```sql
DENSE_RANK() OVER (
    PARTITION BY region
    ORDER BY total_revenue DESC
)