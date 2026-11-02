-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'default2'), (-1, 'RED', NULL), (1, 'RED', 'RED'), (2, '%RED%', 'default1'), (3, '%RED%', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 0, 1, '%RED%'), (0, 'RED', 0, 0, 'default1'), (-1, NULL, NULL, NULL, '%RED%'), (2, 'default2', 0, 0, 'default2'), (3, '%RED%', NULL, 0, 'default2'), (4, NULL, NULL, 1, 'RED'), (5, 'RED', NULL, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 3, 4, '%RED%', 0), (0, -1, 0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default2',)
('default2',)
('%RED%',)
(None,)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON AS S WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS AS O JOIN (SELECT * FROM COMPANY WHERE NAME LIKE '%RED%') AS C ON O.COM_ID = C.COM_ID);

/*
Prediction Result:
(None,)
('default2',)
('default2',)
('%RED%',)
('RED',)
*/