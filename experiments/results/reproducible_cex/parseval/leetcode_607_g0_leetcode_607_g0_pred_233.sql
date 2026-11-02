-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salesperson --
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1, 's_s_f0e0e4', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (2, 's_s_f0e0e4', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (3, 's_s_f0e0e4', 1620389964, 546571701, 'sal_674bfc');

-- Inserting into table: company --
INSERT INTO "company" ("com_id", "name", "city") VALUES (3, 'com_be98d2', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (2, 'com_be98d2', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (1, 'com_be98d2', 'com_269673');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (-2147483648, 2, 3, 'ord_9b8b62', 947159877);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (-2147483647, 2, 2, 'ord_9b8b62', 1408123494);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (-2147483646, 2, 1, 'ord_9b8b62', 700088193);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (2, 1, 3, 'ord_9b8b62', 1149850321);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (3, 1, 1, 'ord_9b8b62', 528680845);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('s_s_f0e0e4',)
('s_s_f0e0e4',)
('s_s_f0e0e4',)
*/

-- Prediction Query
WITH COMBINED_TABLE AS (SELECT NAME, COM_ID, SALESPERSON.SALES_ID FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID), FINAL_TABLE AS (SELECT COMBINED_TABLE.NAME AS PERSON_NAME, COMPANY.NAME AS COMPANY_NAME, COMBINED_TABLE.COM_ID AS COM_ID FROM COMBINED_TABLE LEFT JOIN COMPANY ON COMBINED_TABLE.COM_ID = COMPANY.COM_ID), GROUPED_TABLE AS (SELECT FINAL_TABLE.PERSON_NAME, GROUP_CONCAT(FINAL_TABLE.COMPANY_NAME) AS COMPANY_NAME FROM FINAL_TABLE GROUP BY FINAL_TABLE.PERSON_NAME) SELECT GROUPED_TABLE.PERSON_NAME AS NAME FROM GROUPED_TABLE WHERE GROUPED_TABLE.COMPANY_NAME NOT LIKE '%RED%' OR GROUPED_TABLE.COMPANY_NAME IS NULL;

/*
Prediction Result:
('s_s_f0e0e4',)
*/