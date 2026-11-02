-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 3), (3, '2019-01-01', NULL), (0, 'default2', 3), (2, '2019-01-01', 3), (4, NULL, 1), (5, '2019-03-31', 3), (6, 'default1', 3), (7, 'default2', NULL), (8, '2019-03-31', 3), (9, '2019-01-01', NULL), (10, 'default1', 1), (11, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, 1, '2019-01-02', NULL, 2), (9, 0, 2, NULL, 2, NULL), (3, NULL, 2, '2019-04-01', 3, NULL), (0, 1, NULL, '2019-01-02', 1, 2), (2, 1, 1, '2023-01-02', 1, 1), (1, 1, 3, '2019-01-02', 2, 2), (10, 1, 3, '2023-01-02', NULL, 1), (NULL, 3, 3, '2023-01-02', NULL, 1), (11, 1, 1, '2019-03-31', 3, 3), (9, 1, 2, '2019-03-30', 3, 3), (6, NULL, 0, '2019-01-01', NULL, 3), (6, NULL, 3, '2019-01-01', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default2')
(1, '2019-03-31')
(6, 'default1')
(7, 'default2')
(9, '2019-01-01')
(11, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT P2.PRODUCT_ID FROM SALES AS S2 LEFT JOIN PRODUCT AS P2 ON S2.PRODUCT_ID = P2.PRODUCT_ID WHERE S2.SALE_DATE < '2019-01-01' OR S2.SALE_DATE > '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, P.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/