-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("com_id", "name", "city") VALUES (1019, 'RED_z', 'Port Matthew');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1020, 'Brent Abbott', 1021, 1022, 'PM');
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (1023, 1019, 1020, 'everything', 1024);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Brent Abbott',)
*/

-- Prediction Query
WITH COMBINED_TABLE AS (SELECT NAME, COM_ID, SALESPERSON.SALES_ID FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID), FINAL_TABLE AS (SELECT COMBINED_TABLE.NAME AS PERSON_NAME, COMPANY.NAME AS COMPANY_NAME, COMBINED_TABLE.COM_ID AS COM_ID FROM COMBINED_TABLE LEFT JOIN COMPANY ON COMBINED_TABLE.COM_ID = COMPANY.COM_ID), GROUPED_TABLE AS (SELECT FINAL_TABLE.PERSON_NAME, GROUP_CONCAT(FINAL_TABLE.COMPANY_NAME) AS COMPANY_NAME FROM FINAL_TABLE GROUP BY FINAL_TABLE.PERSON_NAME) SELECT GROUPED_TABLE.PERSON_NAME AS NAME FROM GROUPED_TABLE WHERE GROUPED_TABLE.COMPANY_NAME NOT LIKE '%RED%' OR GROUPED_TABLE.COMPANY_NAME IS NULL;

/*
Prediction Result:
*/