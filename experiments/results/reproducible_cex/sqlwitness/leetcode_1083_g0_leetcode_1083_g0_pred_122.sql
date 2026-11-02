-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, 'default1', NULL), (2, 'iPhone', NULL), (3, 'iPhone', 1), (4, NULL, 1), (5, 'iPhone', NULL), (6, 'default2', NULL), (7, 'default2', NULL), (8, 'default1', 1), (9, 'default1', 1), (10, 'iPhone', NULL), (11, 'default1', NULL), (12, 'S8', NULL), (13, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 0, 1, '2023-01-02', NULL, 1), (13, NULL, NULL, '2023-01-01', 1, NULL), (NULL, 1, 1, '2023-01-02', 1, 1), (6, 1, 0, '2023-01-01', 1, 1), (12, NULL, 0, NULL, NULL, NULL), (12, 0, 1, NULL, 1, 1), (13, NULL, 1, '2023-01-02', NULL, NULL), (3, 0, 0, '2023-01-02', NULL, NULL), (10, 0, NULL, '2023-01-02', NULL, NULL), (1, 0, NULL, '2023-01-02', 1, NULL), (11, NULL, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT DISTINCT (BUYER_ID) FROM SALES) AS S WHERE EXISTS(SELECT * FROM (SELECT DISTINCT (BUYER_ID) FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8') AS S1 WHERE S1.BUYER_ID = S.BUYER_ID) AND NOT EXISTS(SELECT * FROM (SELECT DISTINCT (BUYER_ID) FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone') AS S2 WHERE S2.BUYER_ID = S.BUYER_ID);

/*
Prediction Result:
(1,)
*/