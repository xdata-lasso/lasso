-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'S8', 1465859724);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 1072996612);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -106629402, 1, '2021-02-11', 809183447, 89267185);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1268590800, 1, '2024-03-30', 1115440883, 1644814318);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 700293388, 1, '2023-11-30', 1908028688, 2122220075);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1236688122, 1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1038707349, 1, '2024-07-24', 546571701, 947159877);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 481163439, 1, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -705985602, 1, '2024-02-23', 1178000634, 1836127587);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -2078052421, 1, '2021-12-23', 982314585, 638024588);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 32204797, 1, '2020-05-20', 1784916884, 37673509);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -7597509, 1, '2021-05-12', 1583472758, 1449284300);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -1714354341, 1, '2020-08-13', 1074760385, 1129658414);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1235416111, 1, '2024-10-12', 518609210, 1948383687);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1897687032, 1, '2024-12-22', 199672698, 2119806856);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 944975670, 1, '2024-07-18', 1691780814, 1944978593);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -2072838897, 1, '2021-11-12', 1201273976, 1923659053);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -546516406, 1, '2022-02-07', 1721638020, 983324983);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 697257217, 1, '2024-05-28', 448935289, 458835042);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -489120589, 1, '2021-10-24', 1043710187, 318331233);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -790819470, 1, '2022-04-09', 274891948, 609771851);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -360096930, 1, '2020-07-14', 1435223075, 1617348603);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -268740517, 1, '2025-07-12', 1557188093, 548968280);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1614799674, 1, '2022-07-17', 1774679448, 205676091);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2094843966, 1, '2021-01-21', 1044710644, 966412849);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2140923099, 1, '2024-06-01', 261633665, 748154000);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1933158443, 1, '2025-02-08', 1147652228, 1378873397);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1964331395, 1, '2025-09-04', 1295379066, 1071401016);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 150596046, 1, '2021-07-23', 1510892261, 1677948887);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 389700824, 1, '2024-09-04', 168442149, 1299171592);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1438303683, 1, '2024-07-08', 1966809332, 1487347213);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -2081662466, 1, '2022-12-09', 1509621238, 1432875972);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1573704891, 1, '2025-11-02', 899787662, 594760660);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1670335771, 1, '2024-08-25', 166124233, 1862197286);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -996196097, 1, '2023-04-01', 2042428747, 1228655416);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -388527046, 1, '2020-02-06', 1384307628, 1388796595);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 697582781, 1, '2020-05-16', 1446366856, 438933248);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1944869637, 1, '2023-08-04', 334376591, 1154884242);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1907670428, 1, '2020-05-06', 1731005516, 1388661799);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1582954378, 1, '2021-12-13', 721232773, 323781506);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1663074182, NULL, '2024-09-07', 493701528, 461842658);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 230411875, NULL, '2023-04-30', 1299933788, 679285124);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(1,)
*/