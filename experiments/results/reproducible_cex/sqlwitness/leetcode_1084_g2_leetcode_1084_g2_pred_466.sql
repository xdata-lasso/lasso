-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (2, 'default2', 2), (-1, NULL, NULL), (1, 'default1', 2), (3, NULL, 2), (4, '2019-01-01', NULL), (5, '2019-03-31', 1), (6, '2019-03-31', 1), (7, '2019-01-01', NULL), (8, 'default1', 2), (9, NULL, 2), (10, 'default1', NULL), (11, 'default2', 1), (12, '2019-01-01', 1), (13, '2019-03-31', NULL), (14, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 0, '2019-01-01', 1, 2), (14, -1, 2, NULL, 2, NULL), (1, NULL, 1, NULL, 1, 2), (1, 1, 0, '2019-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, 'default1')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY S.PRODUCT_ID, P.PRODUCT_NAME HAVING SUM(CASE WHEN S.SALE_DATE >= '2019-01-01' AND S.SALE_DATE <= '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
*/