-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("com_id", "name", "city") VALUES (1233, 'RED', 'Lake Lisaport');
INSERT INTO "company" ("com_id", "name", "city") VALUES (1239, 'RED', 'Lake Lisaport');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1234, 'Ashley Humphrey', 1235, 1236, 'everything');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1240, 'Ashley Humphrey', 1235, 1236, 'everything');
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (1237, 1233, 1234, 'business', 1238);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Ashley Humphrey',)
*/

-- Prediction Query
WITH T AS (SELECT ORDER_ID, C.COM_ID, SALES_ID, NAME FROM COMPANY AS C INNER JOIN ORDERS AS O ON C.COM_ID = O.COM_ID), T2 AS (SELECT S.NAME FROM SALESPERSON AS S LEFT JOIN T ON S.SALES_ID = T.SALES_ID WHERE T.NAME = 'RED') SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT NAME FROM T2);

/*
Prediction Result:
*/