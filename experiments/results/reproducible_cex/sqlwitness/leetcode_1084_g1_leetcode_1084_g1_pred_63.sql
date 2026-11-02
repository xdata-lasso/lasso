-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, NULL, 3), (3, 'default2', 3), (2, 'default2', 3), (4, 'default2', NULL), (5, '2019-01-01', NULL), (6, '2019-01-01', 2), (7, '2019-03-31', 2), (8, 'default2', 2), (9, '2019-01-01', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, 2, '2019-01-01', NULL, 2), (5, 0, 3, '2023-01-01', 1, NULL), (8, NULL, NULL, NULL, 2, 1), (7, NULL, 1, '2023-01-01', 2, NULL), (4, 0, 2, '2018-12-31', 2, 2), (NULL, 0, 0, '2019-01-02', 1, 2), (NULL, NULL, 0, '2019-03-30', 2, 2), (1, 3, 1, '2019-04-01', 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(8, 'default2')
*/

-- Prediction Query
SELECT P.PRODUCT_NAME, P.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.SALE_DATE BETWEEN ' 2019-01-01 ' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY 1, 2;

/*
Prediction Result:
*/