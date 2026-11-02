-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 2), (0, 'default2', NULL), (-1, 'default1', NULL), (2, 'default1', 1), (3, 'default1', NULL), (4, '2019-03-31', NULL), (5, '2019-03-31', NULL), (6, NULL, 2), (7, NULL, NULL), (8, '2019-01-01', 2), (9, 'default2', 2), (10, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 1, 2, '2018-12-31', 2, NULL), (-1, NULL, 1, NULL, 2, NULL), (NULL, -1, NULL, '2019-03-30', NULL, NULL), (5, -1, 2, NULL, NULL, 1), (6, 0, 1, NULL, NULL, 1), (10, 0, 1, '2019-01-02', NULL, 1), (5, NULL, NULL, '2018-12-31', NULL, NULL), (4, 2, NULL, '2023-01-01', 2, NULL), (-1, NULL, NULL, '2019-01-01', NULL, 1), (10, -1, 0, NULL, 2, 2), (10, NULL, 0, '2019-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, 'default1')
(10, None)
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1 HAVING COUNT(S.PRODUCT_ID) = SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END);

/*
Prediction Result:
*/