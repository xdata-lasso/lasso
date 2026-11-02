-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'S8', 1465859724);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_bd3179', 1072996612);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -106629402, 1, '2021-02-11', 809183447, 89267185);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1268590800, 1, '2024-03-30', 1115440883, 1644814318);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 700293388, 1, '2023-11-30', 1908028688, 2122220075);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1236688122, 1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1038707349, 1, '2024-07-24', 546571701, 947159877);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 481163439, 1, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -705985602, 1, '2024-02-23', 1178000634, 1836127587);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 894242932, -211209314, '2025-02-11', 806170397, 513454646);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -688216274, 1, '2021-03-20', 1382410067, 1631231566);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 32204797, 1, '2020-05-20', 1784916884, 37673509);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -1388029300, -566887085, '2025-11-20', 602161869, 1350414441);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1427161052, 1, '2023-02-06', 777149609, 61479715);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1194675273, 1, '2023-02-19', 710458518, 678047687);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -163600466, 1, '2020-11-02', 195720193, 1774087382);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -242584410, 1, '2024-08-28', 1870300798, 820970595);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -915385605, -2005628382, '2023-01-12', 983324983, 1269522000);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 195202164, 1, '2023-03-22', 1615073310, 1055237066);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -1351793914, 1, '2025-03-08', 1803796945, 872694102);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -2060082151, 1, '2022-09-04', 319284352, 1164790775);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1719800120, 1, '2020-08-14', 2015094998, 1010672881);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1689155697, 1, '2024-10-05', 681061317, 1935791961);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1942581013, 1, '2025-09-04', 1435223075, 1617348603);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -268740517, 1, '2025-07-12', 1557188093, 548968280);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1614799674, 1, '2022-07-17', 1774679448, 205676091);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2094843966, 1, '2021-01-21', 1044710644, 966412849);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2140923099, 1, '2024-06-01', 261633665, 748154000);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1191116453, 1709667347, '2023-08-11', 1654100852, 30861410);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -438741674, -154207334, '2023-01-25', 2072023304, 789756515);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1160642134, 1, '2025-12-31', 769234989, 168442149);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 917362079, 1, '2024-03-23', 462225708, 1528227252);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1277305894, -1659775598, '2025-02-01', 1220047834, 63063873);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 357443379, -1502591405, '2020-05-12', 973811121, 280292620);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2082238979, 1, '2025-10-05', 1291298007, 1982265552);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -1558272216, 1, '2025-10-16', 195316816, 1728201214);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 316163741, 1, '2020-10-20', 364280973, 1592061050);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 428944759, 1, '2023-04-22', 438933248, 180947503);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -2070247503, 1, '2021-05-09', 313797011, 1946419004);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -553121210, 1720208360, '2023-08-16', 2014610660, 1492264835);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1079009577, -1385967617, '2023-03-09', 719861381, 1193656937);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1184608964, 1, '2024-09-25', 473443538, 1754053934);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -2103849024, 1, '2024-05-04', 1498496406, 370054768);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -662859586, 1, '2023-03-29', 851545765, 987928936);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1517965246, 1, '2024-01-01', 1014069980, 1070869226);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -1415215611, 1, '2024-08-13', 720126052, 629588446);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 973615628, 1, '2024-10-10', 2050088460, 699455208);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 324939521, NULL, '2022-08-27', 1128553504, 1374917235);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 972991637, NULL, '2025-09-21', 1032462616, 980224846);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1659775598,)
(-1502591405,)
(-1385967617,)
(-154207334,)
(1,)
(1709667347,)
(1720208360,)
*/

-- Prediction Query
WITH BUYER_S8 AS (SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'S8'), BUYER_NO_IPHONE AS (SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM BUYER_S8 WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM BUYER_NO_IPHONE);

/*
Prediction Result:
(1,)
(1709667347,)
(-154207334,)
(-1659775598,)
(-1502591405,)
(1720208360,)
(-1385967617,)
(None,)
*/