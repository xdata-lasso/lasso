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
INSERT INTO SALES VALUES (-1, NULL, NULL, NULL, NULL);
INSERT INTO SALES VALUES (0, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM sales;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT SUM(amount) FROM sales;

/*
Prediction Result:
(None,)
*/