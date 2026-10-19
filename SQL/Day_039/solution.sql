/*
============================================================
Day 39: SQL Interview Practice
Topic: Top Sales Representatives by Region
Difficulty: Intermediate–Advanced
Database: Microsoft SQL Server
============================================================

Business Scenario:
A company wants to identify its highest-revenue sales
representatives in each region.

Requirements:
1. Consider only completed deals.
2. Calculate completed deal count for each representative.
3. Calculate total revenue and average deal value.
4. Include representatives with at least 3 completed deals.
5. Rank representatives by total revenue within each region.
6. Return all representatives tied for first place.

SQL Concepts:
- Common Table Expressions (CTEs)
- INNER JOIN
- Aggregate functions
- GROUP BY and HAVING
- DENSE_RANK()
- PARTITION BY
============================================================
*/


/*============================================================
SECTION 1: DROP EXISTING TABLES
============================================================*/

DROP TABLE IF EXISTS sales_deals;
DROP TABLE IF EXISTS sales_reps;
GO


/*============================================================
SECTION 2: CREATE SALES REPRESENTATIVES TABLE
============================================================*/

CREATE TABLE sales_reps
(
    rep_id INT PRIMARY KEY,
    rep_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL
);
GO


/*============================================================
SECTION 3: CREATE SALES DEALS TABLE
============================================================*/

CREATE TABLE sales_deals
(
    deal_id INT PRIMARY KEY,
    rep_id INT NOT NULL,
    deal_date DATE NOT NULL,
    deal_amount DECIMAL(12, 2) NOT NULL,
    deal_status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_sales_deals_sales_reps
        FOREIGN KEY (rep_id)
        REFERENCES sales_reps(rep_id)
);
GO


/*============================================================
SECTION 4: INSERT SALES REPRESENTATIVES
============================================================*/

INSERT INTO sales_reps
    (rep_id, rep_name, region)
VALUES
    (1, 'Asha Patel', 'East'),
    (2, 'Bharat Shah', 'East'),
    (3, 'Charu Mehta', 'East'),
    (4, 'Dev Joshi', 'West'),
    (5, 'Esha Desai', 'West'),
    (6, 'Farhan Khan', 'West'),
    (7, 'Gita Rao', 'North'),
    (8, 'Harsh Trivedi', 'North'),
    (9, 'Ishan Verma', 'North');
GO


/*============================================================
SECTION 5: INSERT SALES DEALS
============================================================*/

INSERT INTO sales_deals
    (deal_id, rep_id, deal_date, deal_amount, deal_status)
VALUES

    -- East Region: Asha Patel
    (101, 1, '2026-09-01', 10000.00, 'Completed'),
    (102, 1, '2026-09-08', 12000.00, 'Completed'),
    (103, 1, '2026-09-15',  8000.00, 'Completed'),
    (104, 1, '2026-09-20',  5000.00, 'Lost'),

    -- East Region: Bharat Shah
    (105, 2, '2026-09-02', 15000.00, 'Completed'),
    (106, 2, '2026-09-10',  9000.00, 'Completed'),
    (107, 2, '2026-09-18',  6000.00, 'Completed'),

    -- East Region: Charu Mehta
    (108, 3, '2026-09-03',  9000.00, 'Completed'),
    (109, 3, '2026-09-11',  8000.00, 'Completed'),
    (110, 3, '2026-09-19',  7000.00, 'Completed'),

    -- West Region: Dev Joshi
    (111, 4, '2026-09-01', 20000.00, 'Completed'),
    (112, 4, '2026-09-09', 10000.00, 'Completed'),
    (113, 4, '2026-09-17',  5000.00, 'Completed'),

    -- West Region: Esha Desai
    (114, 5, '2026-09-04', 15000.00, 'Completed'),
    (115, 5, '2026-09-12', 10000.00, 'Completed'),
    (116, 5, '2026-09-20', 10000.00, 'Completed'),

    -- West Region: Farhan Khan
    (117, 6, '2026-09-05', 11000.00, 'Completed'),
    (118, 6, '2026-09-13',  7000.00, 'Completed'),
    (119, 6, '2026-09-21',  6000.00, 'Completed'),

    -- North Region: Gita Rao
    (120, 7, '2026-09-02', 7000.00, 'Completed'),
    (121, 7, '2026-09-10', 7000.00, 'Completed'),
    (122, 7, '2026-09-18', 7000.00, 'Completed'),

    -- North Region: Harsh Trivedi
    -- Only two completed deals; should be excluded.
    (123, 8, '2026-09-03', 13000.00, 'Completed'),
    (124, 8, '2026-09-11', 12000.00, 'Completed'),

    -- North Region: Ishan Verma
    (125, 9, '2026-09-04', 6000.00, 'Completed'),
    (126, 9, '2026-09-12', 6000.00, 'Completed'),
    (127, 9, '2026-09-20', 6000.00, 'Completed');
GO


/*============================================================
SECTION 6: VERIFY SAMPLE DATA
============================================================*/

SELECT *
FROM sales_reps
ORDER BY region, rep_id;

SELECT *
FROM sales_deals
ORDER BY rep_id, deal_date;
GO


/*============================================================
SECTION 7: SOLUTION QUERY
============================================================*/

WITH RepPerformance AS
(
    SELECT
        r.rep_id,
        r.rep_name,
        r.region,
        COUNT(d.deal_id) AS completed_deals,
        SUM(d.deal_amount) AS total_revenue,
        AVG(d.deal_amount) AS average_deal_value

    FROM sales_reps AS r

    INNER JOIN sales_deals AS d
        ON r.rep_id = d.rep_id

    WHERE d.deal_status = 'Completed'

    GROUP BY
        r.rep_id,
        r.rep_name,
        r.region

    HAVING COUNT(d.deal_id) >= 3
),

RankedReps AS
(
    SELECT
        *,
        DENSE_RANK() OVER
        (
            PARTITION BY region
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM RepPerformance
)

SELECT
    region,
    rep_id,
    rep_name,
    completed_deals,
    total_revenue,
    average_deal_value,
    revenue_rank

FROM RankedReps

WHERE revenue_rank = 1

ORDER BY
    region,
    rep_name;
GO