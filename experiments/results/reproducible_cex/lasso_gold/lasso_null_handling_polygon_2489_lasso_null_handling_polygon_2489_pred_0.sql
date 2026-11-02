-- Schema DDL
CREATE TABLE PRODUCT (PRODUCT_ID INTEGER PRIMARY KEY, PRODUCT_NAME TEXT(255), UNIT_PRICE INTEGER);

CREATE TABLE SALES (PRODUCT_ID INTEGER, SELLER_ID INTEGER, BUYER_ID INTEGER, SALE_DATE DATE, QUANTITY INTEGER, PRICE INTEGER, FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1248, 'James Ferrell', 1249);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1255, 'James Ferrell', 1249);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1261, 'Tricia Valencia', 1256);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1248, 1250, 1251, '2019-02-14', 1252, 1253);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 1257, 1258, '2019-04-01', 1259, 1260);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1248, 'James Ferrell')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/