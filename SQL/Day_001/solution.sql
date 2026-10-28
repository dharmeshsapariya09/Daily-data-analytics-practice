
/*
========================================================
SQL PORTFOLIO - DAY 001
PROJECT: RETAIL RETURNS ANALYSIS
DATABASE: RetailReturnsDB
TOOL: SQL Server Management Studio (SSMS)
========================================================

BUSINESS OBJECTIVE:
Identify products with high return rates and calculate
the value of orders associated with returns.

CONCEPTS:
CREATE DATABASE, CREATE TABLE, PRIMARY KEY, FOREIGN KEY,
CHECK, INSERT, SELECT, INNER JOIN, CASE, COUNT, SUM,
GROUP BY, CAST, ORDER BY.
*/


/*=======================================================
  SECTION 1: CREATE DATABASE
=======================================================*/

IF DB_ID('RetailReturnsDB') IS NULL
BEGIN
    CREATE DATABASE RetailReturnsDB;
END;
GO

USE RetailReturnsDB;
GO


/*=======================================================
  SECTION 2: CREATE TABLES
=======================================================*/

-- Remove existing tables so this script can be rerun.
-- WARNING: This deletes existing data in these tables.

DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Products;
GO


-- Products table
CREATE TABLE dbo.Products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
        CHECK (unit_price >= 0)
);
GO


-- Orders table
CREATE TABLE dbo.Orders
(
    order_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL
        CHECK (order_amount >= 0),
    order_status VARCHAR(20) NOT NULL
        CHECK (
            order_status IN (
                'Delivered',
                'Returned',
                'Cancelled'
            )
        ),

    CONSTRAINT FK_Orders_Products
        FOREIGN KEY (product_id)
        REFERENCES dbo.Products(product_id)
);
GO


/*=======================================================
  SECTION 3: INSERT PRODUCT DATA
=======================================================*/

INSERT INTO dbo.Products
    (product_id, product_name, category, unit_price)
VALUES
    (101, 'Wireless Mouse', 'Electronics', 799.00),
    (102, 'Mechanical Keyboard', 'Electronics', 2499.00),
    (103, 'Office Chair', 'Furniture', 5999.00),
    (104, 'Water Bottle', 'Accessories', 499.00),
    (105, 'Laptop Stand', 'Accessories', 1299.00);
GO


/*=======================================================
  SECTION 4: INSERT ORDER DATA
=======================================================*/

INSERT INTO dbo.Orders
    (order_id, product_id, order_date, order_amount, order_status)
VALUES
    (1001, 101, '2026-10-01', 799.00, 'Delivered'),
    (1002, 101, '2026-10-02', 799.00, 'Returned'),
    (1003, 101, '2026-10-03', 799.00, 'Delivered'),
    (1004, 101, '2026-10-04', 799.00, 'Returned'),

    (1005, 102, '2026-10-05', 2499.00, 'Delivered'),
    (1006, 102, '2026-10-06', 2499.00, 'Delivered'),
    (1007, 102, '2026-10-07', 2499.00, 'Returned'),

    (1008, 103, '2026-10-08', 5999.00, 'Delivered'),
    (1009, 103, '2026-10-09', 5999.00, 'Delivered'),
    (1010, 103, '2026-10-10', 5999.00, 'Delivered'),

    (1011, 104, '2026-10-11', 499.00, 'Returned'),
    (1012, 104, '2026-10-12', 499.00, 'Delivered'),
    (1013, 104, '2026-10-13', 499.00, 'Returned'),
    (1014, 104, '2026-10-14', 499.00, 'Delivered'),

    (1015, 105, '2026-10-15', 1299.00, 'Delivered'),
    (1016, 105, '2026-10-16', 1299.00, 'Delivered'),
    (1017, 105, '2026-10-17', 1299.00, 'Delivered'),
    (1018, 105, '2026-10-18', 1299.00, 'Returned');
GO


/*=======================================================
  SECTION 5: VERIFY INSERTED DATA
=======================================================*/

SELECT *
FROM dbo.Products
ORDER BY product_id;

SELECT *
FROM dbo.Orders
ORDER BY order_id;
GO


/*=======================================================
  SECTION 6: RETAIL RETURNS ANALYSIS
=======================================================*/

SELECT
    p.product_id,
    p.product_name,

    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN o.order_status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders,

    CAST(
        100.0 * SUM(
            CASE
                WHEN o.order_status = 'Returned' THEN 1
                ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(5, 2)
    ) AS return_rate_percentage,

    CAST(
        SUM(
            CASE
                WHEN o.order_status = 'Returned'
                    THEN o.order_amount
                ELSE 0
            END
        )
        AS DECIMAL(12, 2)
    ) AS returned_revenue,

    CASE
        WHEN
            100.0 * SUM(
                CASE
                    WHEN o.order_status = 'Returned' THEN 1
                    ELSE 0
                END
            ) / COUNT(*) >= 30
            THEN 'High Return Rate'

        WHEN
            100.0 * SUM(
                CASE
                    WHEN o.order_status = 'Returned' THEN 1
                    ELSE 0
                END
            ) / COUNT(*) >= 15
            THEN 'Medium Return Rate'

        ELSE 'Low Return Rate'
    END AS return_category

FROM dbo.Products AS p

INNER JOIN dbo.Orders AS o
    ON p.product_id = o.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY
    return_rate_percentage DESC,
    returned_orders DESC;
GO


/*=======================================================
  END OF DAY 001 PROJECT
=======================================================*/
