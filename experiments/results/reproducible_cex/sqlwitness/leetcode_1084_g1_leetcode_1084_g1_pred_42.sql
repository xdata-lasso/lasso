-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, 'default1', NULL), (2, '2019-01-01', NULL), (3, NULL, NULL), (4, '2019-03-31', NULL), (5, '2019-01-01', NULL), (6, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, NULL, '2019-01-02', NULL, NULL), (0, 1, NULL, NULL, 1, 1), (4, 0, 0, '2019-01-01', NULL, 1), (5, 0, NULL, '2019-01-02', NULL, NULL), (6, 0, 0, '2019-03-30', 1, 1), (6, NULL, 0, '2019-01-02', 1, 1), (6, NULL, 1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, None)
(0, 'default1')
(4, '2019-03-31')
(5, '2019-01-01')
(6, None)
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PRODUCT_NAME FROM SALES JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT SALES.PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY PRODUCT.PRODUCT_ID;

/*
Prediction Result:
(3, None)
(4, '2019-03-31')
(5, '2019-01-01')
(6, None)
*/