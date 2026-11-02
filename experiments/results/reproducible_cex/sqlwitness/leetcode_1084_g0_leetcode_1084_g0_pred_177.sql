-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 1), (1, 'default2', NULL), (2, '2019-03-31', NULL), (3, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 0, '2023-01-02', 1, NULL), (1, NULL, NULL, '2019-03-31', NULL, 1), (NULL, 0, 0, '2019-03-31', 1, NULL), (NULL, NULL, 0, '2019-01-01', NULL, NULL), (NULL, 1, NULL, NULL, NULL, 1), (NULL, NULL, NULL, '2018-12-31', NULL, NULL), (NULL, 0, 0, '2018-12-31', NULL, NULL), (2, NULL, 0, '2019-01-01', NULL, 1), (2, 1, NULL, NULL, 1, NULL), (3, 1, NULL, NULL, 1, 1), (NULL, 1, 0, NULL, 1, NULL), (1, 0, NULL, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT A.PRODUCT_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.SALE_DATE < '2019-01-01' OR A.SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/