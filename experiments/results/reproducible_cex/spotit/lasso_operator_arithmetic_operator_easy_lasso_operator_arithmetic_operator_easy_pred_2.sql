-- Schema DDL
CREATE TABLE "PRODUCTS" (
    "PRODUCT_ID" INT,
    "NAME" TEXT,
    "CATEGORY" TEXT,
    "PRICE" FLOAT,
    "COST" FLOAT,
    "STOCK_QUANTITY" INT,
    PRIMARY KEY ("PRODUCT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PRODUCTS VALUES (-1, 0, 0, 51, 0, 0);
INSERT INTO PRODUCTS VALUES (0, 0, 0, 0, -51, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Products WHERE price - cost > 50;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT name FROM Products WHERE price / cost > 50;

/*
Prediction Result:
*/