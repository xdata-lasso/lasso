-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, 'default2', NULL), (2, 'iPhone', NULL), (-1, 'iPhone', 1), (3, 'S8', NULL), (4, 'default1', 2), (5, NULL, NULL), (6, 'S8', 2), (7, 'default1', 2), (8, 'default1', 2), (9, 'default2', NULL), (10, NULL, 1), (11, 'iPhone', 2), (12, 'default2', NULL), (13, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 0, NULL, 1, 2), (13, NULL, NULL, NULL, NULL, 1), (11, 1, 0, '2023-01-02', NULL, NULL), (3, 1, 1, NULL, NULL, 1), (10, -1, 1, '2023-01-02', 2, NULL), (1, 1, NULL, '2023-01-01', NULL, 1), (12, -1, 2, NULL, 2, 2), (4, -1, -1, '2023-01-01', 1, 1), (1, 1, 2, NULL, 2, NULL), (-1, 2, 0, '2023-01-02', 2, 2), (13, -1, NULL, '2023-01-01', 2, 1), (12, 1, -1, '2023-01-02', 1, NULL), (7, 0, 0, '2023-01-02', NULL, 2), (3, 2, 0, '2023-01-02', 2, NULL), (12, 1, 0, '2023-01-01', 2, 2), (4, 1, 0, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') >= 1 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(1,)
(2,)
*/