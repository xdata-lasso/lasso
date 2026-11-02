-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'default1', 3), (3, 'default1', 3), (2, 'default1', 1), (4, NULL, NULL), (5, '2019-01-01', 3), (6, 'default2', 2), (7, '2019-01-01', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 2, 2, '2023-01-02', NULL, 3), (NULL, 0, 3, '2018-12-31', NULL, 1), (5, 2, 3, NULL, 1, 1), (7, NULL, NULL, '2019-04-01', NULL, NULL), (0, 3, 1, '2019-03-30', NULL, 2), (7, 0, 3, '2019-01-01', 2, 3), (1, 3, 0, '2019-01-02', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default1')
(1, 'default1')
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PRODUCT_NAME FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, SALES.PRODUCT_ID NULLS LAST, PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/