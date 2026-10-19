/*
============================================================
Day 40: SQL Interview Practice
Topic: Identify Frequently Purchased Product Pairs
Difficulty: Intermediate-Advanced
Database: Microsoft SQL Server

Business Scenario:
E-commerce and retail analytics.

Objective:
Identify product pairs purchased together in at least
three distinct orders.

SQL Concepts:
1. CREATE TABLE
2. PRIMARY KEY and CHECK constraint
3. INSERT INTO
4. Common Table Expressions (CTEs)
5. INNER JOIN / Self-Join
6. COUNT(DISTINCT)
7. GROUP BY
8. Filtering and ORDER BY
============================================================
*/


/*==========================================================
SECTION 1: CREATE SAMPLE TABLE
==========================================================*/

DROP TABLE IF EXISTS order_items;
GO

CREATE TABLE order_items
(
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,

    CONSTRAINT PK_order_items
        PRIMARY KEY (order_id, product_id),

    CONSTRAINT CK_order_items_quantity
        CHECK (quantity > 0)
);
GO


/*==========================================================
SECTION 2: INSERT SAMPLE DATA
==========================================================*/

INSERT INTO order_items
    (order_id, product_id, product_name, quantity)
VALUES

-- Order 1001
(1001, 101, 'Laptop', 1),
(1001, 102, 'Wireless Mouse', 1),
(1001, 103, 'Keyboard', 1),

-- Order 1002
(1002, 101, 'Laptop', 1),
(1002, 102, 'Wireless Mouse', 1),

-- Order 1003
(1003, 101, 'Laptop', 1),
(1003, 102, 'Wireless Mouse', 1),
(1003, 104, 'Laptop Bag', 1),

-- Order 1004
(1004, 102, 'Wireless Mouse', 2),
(1004, 103, 'Keyboard', 1),

-- Order 1005
(1005, 101, 'Laptop', 1),
(1005, 102, 'Wireless Mouse', 1),

-- Order 1006
(1006, 102, 'Wireless Mouse', 1),
(1006, 103, 'Keyboard', 1),

-- Order 1007
(1007, 101, 'Laptop', 1),
(1007, 104, 'Laptop Bag', 1),

-- Order 1008
(1008, 102, 'Wireless Mouse', 1),
(1008, 103, 'Keyboard', 1),

-- Order 1009
(1009, 105, 'USB Hub', 1),
(1009, 106, 'External Drive', 1);
GO


/*==========================================================
SECTION 3: VERIFY SAMPLE DATA
==========================================================*/

SELECT
    order_id,
    product_id,
    product_name,
    quantity
FROM order_items
ORDER BY
    order_id,
    product_id;
GO


/*==========================================================
SECTION 4: IDENTIFY PRODUCT PAIRS
==========================================================*/

WITH ProductPairs AS
(
    SELECT
        a.product_id AS product_id_1,
        a.product_name AS product_name_1,

        b.product_id AS product_id_2,
        b.product_name AS product_name_2,

        a.order_id

    FROM order_items AS a

    INNER JOIN order_items AS b
        ON a.order_id = b.order_id

        -- Avoid pairing a product with itself
        -- and avoid reversed duplicate pairs
        AND a.product_id < b.product_id
),

PairFrequency AS
(
    SELECT
        product_id_1,
        product_name_1,
        product_id_2,
        product_name_2,

        COUNT(DISTINCT order_id) AS orders_together

    FROM ProductPairs

    GROUP BY
        product_id_1,
        product_name_1,
        product_id_2,
        product_name_2
)

SELECT
    product_name_1,
    product_name_2,
    orders_together

FROM PairFrequency

-- Return product pairs appearing in at least 3 orders
WHERE orders_together >= 3

ORDER BY
    orders_together DESC,
    product_name_1,
    product_name_2;
GO


/*==========================================================
SECTION 5: EXPECTED RESULT

product_name_1       product_name_2       orders_together
---------------------------------------------------------
Laptop               Wireless Mouse      4
Wireless Mouse       Keyboard             4

Note:
The expected count for Wireless Mouse + Keyboard is 4,
because the pair appears in orders 1001, 1004, 1006,
and 1008.

==========================================================*/