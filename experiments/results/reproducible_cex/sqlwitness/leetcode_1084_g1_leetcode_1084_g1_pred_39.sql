-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (2, 'default2', NULL), (-1, 'default1', 1), (1, '2019-03-31', 2), (3, 'default1', NULL), (4, '2019-01-01', NULL), (5, 'default1', 2), (6, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, NULL, '2019-01-02', 2, 1), (-1, 1, NULL, '2019-04-01', 1, 2), (1, 2, 2, NULL, NULL, 1), (4, 2, NULL, '2019-01-02', 1, 1), (0, -1, NULL, '2019-04-01', 1, 1), (2, -1, 1, '2019-03-31', 1, NULL), (NULL, NULL, 0, '2019-03-30', NULL, NULL), (0, NULL, 1, NULL, 2, 1), (4, -1, -1, '2023-01-02', 2, NULL), (2, -1, -1, '2018-12-31', 1, 2), (3, 2, 0, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(5, 'default1')
(1, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING SUM(CASE WHEN S.SALE_DATE < DATE('2019-01-01') OR S.SALE_DATE > DATE('2019-03-31') THEN 1 ELSE 0 END) < 1 AND SUM(CASE WHEN S.SALE_DATE >= DATE('2019-01-01') OR S.SALE_DATE <= DATE('2019-03-31') THEN 1 ELSE 0 END) >= 1;

/*
Prediction Result:
(5, 'default1')
*/