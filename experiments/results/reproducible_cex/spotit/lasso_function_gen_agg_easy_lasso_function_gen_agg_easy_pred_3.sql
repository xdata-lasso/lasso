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
INSERT INTO SALES VALUES (0, 0, 0, 0, '0001-01-01');
INSERT INTO SALES VALUES (-1, 0, 0, 6, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT AVG(amount) FROM sales;

/*
Prediction Result:
(3.0,)
*/