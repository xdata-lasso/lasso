-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483648, 'S8', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483646, 'S8', 1019800248);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'S8', 429706943);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_bd3179', 462974032);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483643, 'S8', 392822403);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483642, 'S8', 1784916884);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483641, 'S8', 804529642);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483640, 'S8', 2078438287);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483639, 'S8', 1722106924);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483638, 'S8', 1269522000);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483637, 'S8', 1849819405);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483636, 'S8', 1953495465);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483635, 'S8', 1483450542);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1633151678, 1, '2021-07-04', 1914020640, 1268590800);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1219478689, 1, '2023-08-23', 1644814318, 1465859724);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1419861592, 1, '2025-04-12', 374105386, 1274489983);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 481163439, 1, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -705985602, 1, '2024-02-23', 1178000634, 1836127587);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -2078052421, 1, '2021-12-23', 982314585, 638024588);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -2115841792, 1, '2025-08-02', 1360271423, 1583472758);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -491938169, 1, '2022-09-06', 1972233925, 1792827279);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1538707438, 1, '2025-03-06', 1476361420, 195720193);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1774087382, 1, '2020-02-26', 2035306060, 1523825314);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1897687032, 1, '2024-12-22', 199672698, 2119806856);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 944975670, 1, '2024-07-18', 1691780814, 1944978593);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2072838897, 1, '2021-11-12', 1201273976, 1923659053);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -546516406, 1, '2022-02-07', 1721638020, 983324983);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 195202164, 1, '2023-03-22', 1615073310, 1055237066);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -229022515, 1, '2020-11-10', 1908593332, 697257217);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2013213247, 1, '2022-05-21', 234957614, 823835795);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -613916489, 1, '2022-01-03', 895277769, 364043263);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1960313034, NULL, '2020-07-19', 453340472, 211603887);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -413043724, NULL, '2021-11-11', 1504707292, 955267863);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -795975227, 1, '2024-05-11', 778835680, 1755752040);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 7342822, 1, '2022-11-27', 287256667, 1614799674);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME IN (SELECT PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT S.BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
(1,)
(None,)
*/