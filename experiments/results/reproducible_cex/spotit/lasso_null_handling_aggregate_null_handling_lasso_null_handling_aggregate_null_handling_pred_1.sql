-- Schema DDL
CREATE TABLE "PRODUCTS" (
    "PRODUCT_ID" INT,
    "PRODUCT_NAME" TEXT,
    "CATEGORY" TEXT,
    "RATING" FLOAT,
    PRIMARY KEY ("PRODUCT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PRODUCTS VALUES (-1, 0, 0, NULL);
INSERT INTO PRODUCTS VALUES (0, 0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(rating) FROM Products;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(product_id) FROM Products;

/*
Prediction Result:
(2,)
*/