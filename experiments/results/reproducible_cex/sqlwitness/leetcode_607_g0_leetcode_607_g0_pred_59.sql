-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, NULL, 1, 1, 'default1'), (1, 'default1', 2, 1, 'RED'), (-1, NULL, NULL, 0, 'RED');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S LEFT JOIN ORDERS AS O ON O.SALES_ID = S.SALES_ID LEFT JOIN COMPANY AS C ON O.COM_ID = C.COM_ID GROUP BY S.NAME HAVING SUM(CASE WHEN C.NAME = 'RED' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
('default1',)
*/