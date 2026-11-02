-- Schema DDL
CREATE TABLE "SALES" (
    "ID" INT,
    "PRODUCT_NAME" TEXT,
    "CATEGORY" TEXT,
    "AMOUNT" FLOAT,
    "SALE_DATE" DATE,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SALES VALUES (-2147483648, 14, 7, 0, '0001-01-01');
INSERT INTO SALES VALUES (-2147483647, 14, 7, -2, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
('7', 2, -2.0, -1.0, 0.0, -2.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, COUNT(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
('7', 2, 2, -1.0, 0.0, -2.0)
*/