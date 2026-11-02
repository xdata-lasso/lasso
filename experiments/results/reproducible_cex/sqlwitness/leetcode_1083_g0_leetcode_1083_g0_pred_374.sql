-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', NULL), (2, 'default2', 2), (1, 'default1', 2), (3, 'default1', NULL), (4, 'default2', 1), (5, NULL, 1), (6, 'S8', 2), (7, NULL, NULL), (8, 'iPhone', 1), (9, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 0, '2023-01-01', NULL, 2), (7, 2, NULL, '2023-01-02', 2, NULL), (2, NULL, 2, NULL, 1, NULL), (0, NULL, 2, '2023-01-02', 1, NULL), (9, 2, 0, '2023-01-01', 1, NULL), (9, 0, 0, '2023-01-01', 1, NULL), (9, NULL, 1, '2023-01-01', NULL, NULL), (6, 2, NULL, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT EXISTS(SELECT 1 FROM SALES AS S2 JOIN PRODUCT AS P2 ON S2.PRODUCT_ID = P2.PRODUCT_ID AND S2.BUYER_ID = S.BUYER_ID AND P2.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
*/