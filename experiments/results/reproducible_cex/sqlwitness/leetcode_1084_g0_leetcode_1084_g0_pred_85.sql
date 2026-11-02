-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (2, 'default2', 1), (3, '2019-01-01', 1), (0, NULL, 2), (4, 'default2', NULL), (5, NULL, NULL), (6, NULL, NULL), (7, 'default1', 3), (8, '2019-03-31', 1), (9, 'default1', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, 3, '2019-04-01', NULL, 3), (0, 2, 3, '2018-12-31', 2, 2), (7, 1, NULL, '2019-01-02', NULL, 2), (2, 1, NULL, '2019-01-02', 3, 1), (NULL, 3, 1, '2019-04-01', 2, 2), (7, 1, 0, '2023-01-01', NULL, 2), (1, 3, 3, '2023-01-02', 2, 2), (NULL, 3, 0, '2019-01-02', NULL, 3), (2, 2, 3, NULL, NULL, 2), (NULL, 3, NULL, '2018-12-31', 1, 2), (0, 0, NULL, '2019-01-02', 1, 3), (6, NULL, 1, '2019-03-31', 2, 1), (2, 2, 3, NULL, 3, 2), (1, NULL, 3, '2018-12-31', 3, NULL), (5, NULL, 2, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(2, 'default2')
(5, None)
(6, None)
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PR.PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT AS PR ON SALES.PRODUCT_ID = PR.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY 1, 2;

/*
Prediction Result:
*/