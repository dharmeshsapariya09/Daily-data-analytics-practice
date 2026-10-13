/*
=========================================================
Day 38: SQL Interview Practice
Topic: Detect Potential Duplicate Vendor Invoices
Difficulty: Intermediate–Advanced
Database: Microsoft SQL Server
=========================================================

Business Scenario:
Finance, accounts payable, and data quality.

Objective:
Identify potential duplicate vendor invoices when invoice
numbers have inconsistent formatting.

Duplicate detection criteria:
1. Same vendor
2. Same normalized invoice number
3. Same invoice amount
4. Invoice dates within 30 days

=========================================================
SECTION 1: CREATE SAMPLE TABLE
=========================================================
*/

DROP TABLE IF EXISTS vendor_invoices;
GO

CREATE TABLE vendor_invoices
(
    invoice_id INT PRIMARY KEY,
    vendor_id INT NOT NULL,
    vendor_name VARCHAR(100) NOT NULL,
    invoice_number VARCHAR(50) NOT NULL,
    invoice_date DATE NOT NULL,
    invoice_amount DECIMAL(12, 2) NOT NULL
);
GO

/*
=========================================================
SECTION 2: INSERT SAMPLE DATA
=========================================================
*/

INSERT INTO vendor_invoices
(
    invoice_id,
    vendor_id,
    vendor_name,
    invoice_number,
    invoice_date,
    invoice_amount
)
VALUES
-- Potential duplicate: formatting differs
(1, 10, 'Acme Technologies',
 'INV-1001', '2026-10-01', 1200.00),

(2, 10, 'Acme Technologies',
 'inv 1001', '2026-10-05', 1200.00),

-- Potential duplicate: same invoice number and amount
(3, 10, 'Acme Technologies',
 'INV-1002', '2026-10-03', 850.00),

(4, 10, 'Acme Technologies',
 'INV-1002', '2026-10-25', 850.00),

-- Same invoice number but a different vendor
(5, 11, 'Bright Office Supplies',
 'INV-1001', '2026-10-02', 1200.00),

-- Same vendor and invoice number, but different amount
(6, 10, 'Acme Technologies',
 'INV-1001', '2026-10-06', 1250.00),

-- Outside the 30-day window
(7, 10, 'Acme Technologies',
 'INV-1001', '2026-12-01', 1200.00),

-- Potential duplicate: formatting differs
(8, 10, 'Acme Technologies',
 'INV-1003', '2026-10-07', 400.00),

(9, 10, 'Acme Technologies',
 'INV 1003', '2026-10-08', 400.00);
GO

/*
=========================================================
SECTION 3: SOLUTION QUERY
=========================================================
*/

WITH NormalizedInvoices AS
(
    SELECT
        invoice_id,
        vendor_id,
        vendor_name,
        invoice_number,

        UPPER(
            REPLACE(
                REPLACE(
                    LTRIM(RTRIM(invoice_number)),
                    ' ',
                    ''
                ),
                '-',
                ''
            )
        ) AS normalized_invoice_number,

        invoice_date,
        invoice_amount

    FROM vendor_invoices
)

SELECT
    a.vendor_id,
    a.vendor_name,

    a.invoice_id AS invoice_id_1,
    b.invoice_id AS invoice_id_2,

    a.normalized_invoice_number,

    a.invoice_date AS invoice_date_1,
    b.invoice_date AS invoice_date_2,

    a.invoice_amount,

    ABS(
        DATEDIFF(
            DAY,
            a.invoice_date,
            b.invoice_date
        )
    ) AS days_between_invoices

FROM NormalizedInvoices AS a

INNER JOIN NormalizedInvoices AS b
    ON a.vendor_id = b.vendor_id

    AND a.normalized_invoice_number =
        b.normalized_invoice_number

    AND a.invoice_amount = b.invoice_amount

    AND a.invoice_id < b.invoice_id

    AND ABS(
        DATEDIFF(
            DAY,
            a.invoice_date,
            b.invoice_date
        )
    ) <= 30

ORDER BY
    a.vendor_id,
    a.invoice_date;
GO