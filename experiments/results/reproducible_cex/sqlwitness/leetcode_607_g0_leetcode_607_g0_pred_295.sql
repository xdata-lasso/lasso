-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', NULL), (0, 'RED', 'RED'), (-1, 'RED', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', 1, NULL, 'RED'), (0, 'default1', 0, 1, 'default2'), (1, 'default1', NULL, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 1, 1, NULL, NULL), (1, -1, 0, NULL, 0), (0, 1, 1, 'default2', 0), (2, NULL, NULL, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
WITH TEST AS (SELECT SS.NAME AS NAME1, OO.COM_ID, CC.NAME AS NAMEC FROM SALESPERSON AS SS LEFT JOIN ORDERS AS OO ON SS.SALES_ID = OO.SALES_ID LEFT JOIN COMPANY AS CC ON OO.COM_ID = CC.COM_ID) SELECT DISTINCT NAME1 AS NAME FROM TEST WHERE NOT NAME1 IN (SELECT NAME1 FROM TEST WHERE NAMEC = 'RED');

/*
Prediction Result:
*/