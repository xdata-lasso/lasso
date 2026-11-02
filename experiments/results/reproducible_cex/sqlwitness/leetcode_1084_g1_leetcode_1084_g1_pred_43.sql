-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 3), (0, NULL, 1), (3, '2019-03-31', NULL), (1, 'default2', 3), (4, 'default1', NULL), (5, '2019-01-01', NULL), (6, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 1, '2019-01-01', NULL, 1), (1, 0, 3, '2019-03-31', NULL, NULL), (NULL, NULL, 0, '2019-01-01', 1, 2), (0, 3, 3, '2023-01-02', 3, NULL), (3, 0, 1, '2019-03-31', 1, 2), (4, 3, NULL, '2018-12-31', 2, NULL), (3, 2, 3, '2019-04-01', 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(5, '2019-01-01')
(1, 'default2')
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PRODUCT_NAME FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, SALES.PRODUCT_ID NULLS LAST, PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(1, 'default2')
(5, '2019-01-01')
*/