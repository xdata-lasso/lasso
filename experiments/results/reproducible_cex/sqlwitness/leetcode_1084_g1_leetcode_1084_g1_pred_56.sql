-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 3), (3, 'default2', 1), (1, NULL, NULL), (0, '2019-03-31', 2), (4, NULL, 3), (5, NULL, 1), (6, '2019-03-31', 3), (7, 'default2', 2), (8, NULL, 2), (9, NULL, 3), (10, 'default2', NULL), (11, '2019-01-01', 1), (12, 'default2', 2), (13, 'default1', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 1, 0, '2019-01-02', 3, 3), (5, 1, 1, '2019-01-01', 2, NULL), (9, 0, NULL, '2019-04-01', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(13, 'default1')
(5, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, P.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(5, None)
(13, 'default1')
*/