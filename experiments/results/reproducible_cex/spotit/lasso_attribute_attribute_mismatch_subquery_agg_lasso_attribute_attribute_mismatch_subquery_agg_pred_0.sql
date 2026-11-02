-- Schema DDL
CREATE TABLE "PRODUCTS" (
    "PRODUCT_ID" INT,
    "PRODUCT_NAME" TEXT NOT NULL,
    "CATEGORY_CODE" TEXT NOT NULL,
    "CATEGORY_NAME" TEXT NOT NULL,
    PRIMARY KEY ("PRODUCT_ID")
);
CREATE TABLE "SALES" (
    "SALE_ID" INT,
    "PRODUCT_ID" INT NOT NULL,
    "QUANTITY" INT NOT NULL,
    "DISCOUNT" INT NOT NULL,
    PRIMARY KEY ("SALE_ID"),
    FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCTS"("PRODUCT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PRODUCTS VALUES (0, 13, 14, 15);
INSERT INTO PRODUCTS VALUES (-1, 16, 17, 18);
INSERT INTO SALES VALUES (0, 0, -2, 0);
INSERT INTO SALES VALUES (1, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.product_name, P.category_code FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Gold Result:
('16', '17')
*/

-- Prediction Query
SELECT P.product_name, P.category_name FROM Products AS P JOIN Sales AS S ON P.product_id = S.product_id WHERE (S.quantity - S.discount) > (SELECT AVG(S2.quantity - S2.discount) FROM Sales AS S2);

/*
Prediction Result:
('16', '18')
*/