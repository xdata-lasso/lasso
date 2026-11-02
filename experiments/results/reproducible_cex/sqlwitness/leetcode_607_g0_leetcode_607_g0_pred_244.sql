-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default1', NULL), (-1, NULL, 'RED'), (0, 'default1', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default2', 1, 0, 'default2'), (-1, 'default2', 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
WITH TEMP_TABLE AS (SELECT SALESPERSON.SALES_ID, SALESPERSON.NAME AS PERSON, COMPANY.NAME AS NAME FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID) SELECT DISTINCT PERSON AS NAME FROM TEMP_TABLE WHERE NOT PERSON IN (SELECT PERSON FROM TEMP_TABLE WHERE NAME = 'RED');

/*
Prediction Result:
('default2',)
*/