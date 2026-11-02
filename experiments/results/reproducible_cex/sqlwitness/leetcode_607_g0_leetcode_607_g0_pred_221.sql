-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'default2'), (0, '%RED%', '%RED%'), (-1, 'default2', '%RED%'), (2, 'default1', 'default1'), (3, 'RED', '%RED%'), (4, NULL, 'default2'), (5, 'RED', 'RED'), (6, 'default1', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', NULL, 0, 'default2'), (-1, 'RED', 0, NULL, NULL), (1, 'default1', 1, NULL, 'default1'), (2, '%RED%', 1, NULL, '%RED%'), (3, 'default2', NULL, NULL, 'RED'), (4, NULL, 1, NULL, 'default1'), (5, 'RED', 1, NULL, 'default1'), (6, 'default1', NULL, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 0, -1, 'RED', 0), (-1, 2, NULL, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default1',)
('default1',)
('%RED%',)
('default2',)
(None,)
('RED',)
('default1',)
*/

-- Prediction Query
WITH COMBINED_TABLE AS (SELECT NAME, COM_ID, SALESPERSON.SALES_ID FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID), FINAL_TABLE AS (SELECT COMBINED_TABLE.NAME AS PERSON_NAME, COMPANY.NAME AS COMPANY_NAME, COMBINED_TABLE.COM_ID AS COM_ID FROM COMBINED_TABLE LEFT JOIN COMPANY ON COMBINED_TABLE.COM_ID = COMPANY.COM_ID), GROUPED_TABLE AS (SELECT FINAL_TABLE.PERSON_NAME, GROUP_CONCAT(FINAL_TABLE.COMPANY_NAME) AS COMPANY_NAME FROM FINAL_TABLE GROUP BY FINAL_TABLE.PERSON_NAME) SELECT GROUPED_TABLE.PERSON_NAME AS NAME FROM GROUPED_TABLE WHERE GROUPED_TABLE.COMPANY_NAME NOT LIKE '%RED%' OR GROUPED_TABLE.COMPANY_NAME IS NULL;

/*
Prediction Result:
(None,)
('%RED%',)
('default1',)
('default2',)
*/