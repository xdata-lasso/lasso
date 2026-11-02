-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, NULL), (0, 'iPhone', NULL), (-1, 'iPhone', 1), (1, 'default2', 1), (3, 'default1', 1), (4, 'iPhone', NULL), (5, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, NULL, '2023-01-02', 1, 1), (5, 1, 2, NULL, NULL, 2), (4, 0, -1, '2023-01-02', NULL, NULL), (3, 1, NULL, '2023-01-02', 2, NULL), (NULL, 1, 0, NULL, 1, NULL), (NULL, 0, 0, NULL, 2, NULL), (NULL, 1, 1, '2023-01-01', 2, 2), (0, 2, 1, '2023-01-02', 1, NULL), (5, 0, NULL, '2023-01-01', NULL, 2), (NULL, 2, 0, '2023-01-01', 2, 2), (4, -1, 0, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT JOIN SALES USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone' OR PRODUCT_NAME = 'S8' GROUP BY BUYER_ID HAVING SUM(IIF(PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(None,)
(2,)
*/