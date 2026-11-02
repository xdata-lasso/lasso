-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("com_id", "name", "city") VALUES (1108, 'RED', 'East Nathaniel');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1109, 'Troy Nielsen', 1110, 1111, 'why');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1119, NULL, NULL, NULL, NULL);
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (1112, 1108, 1109, 'a', 1113);
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (1116, 1108, 1119, 'a', 1113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT SP.NAME AS NAME, P.NAME AS PNAME FROM SALESPERSON AS SP LEFT OUTER JOIN (SELECT P.SALES_ID, P.NAME FROM SALESPERSON AS P INNER JOIN ORDERS AS O ON P.SALES_ID = O.SALES_ID INNER JOIN COMPANY AS C ON O.COM_ID = C.COM_ID AND C.NAME = 'RED') AS P ON SP.SALES_ID = P.SALES_ID) SELECT NAME FROM TEMP WHERE PNAME IS NULL;

/*
Prediction Result:
(None,)
*/