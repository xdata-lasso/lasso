-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'RED'), (-1, 'default2', 'default1'), (1, 'RED', 'RED'), (2, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default2', 0, 1, 'RED'), (1, 'RED', NULL, 1, 'default2'), (-1, 'default2', 0, 1, NULL), (2, 'RED', 0, 0, NULL), (3, NULL, 0, 0, 'RED'), (4, 'default1', 0, NULL, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 2, 2, 'default1', 0), (1, 1, 1, 'default1', 0), (-1, NULL, 0, 'RED', 0), (2, 0, 1, NULL, 0), (3, 0, -1, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
('RED',)
(None,)
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S LEFT JOIN ORDERS AS O USING (SALES_ID) LEFT JOIN COMPANY AS C USING (COM_ID) GROUP BY S.SALES_ID HAVING SUM(C.NAME = 'RED') = 0 OR COUNT(O.ORDER_ID) = 0;

/*
Prediction Result:
('default2',)
(None,)
('default1',)
*/