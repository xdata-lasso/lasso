-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, NULL), (1, 'default1', 'RED'), (0, 'default1', 'default1'), (2, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, NULL, 1, NULL), (1, 'RED', 1, NULL, 'RED'), (0, 'RED', 0, NULL, NULL), (2, NULL, 0, 0, 'default1'), (3, 'RED', NULL, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('RED',)
(None,)
('RED',)
*/

-- Prediction Query
SELECT DISTINCT A.NAME FROM SALESPERSON AS A LEFT JOIN ORDERS AS B ON A.SALES_ID = B.SALES_ID WHERE NOT A.SALES_ID IN (SELECT SALES_ID FROM ORDERS AS AA JOIN COMPANY AS BB ON AA.COM_ID = BB.COM_ID WHERE BB.NAME = 'RED');

/*
Prediction Result:
(None,)
('RED',)
*/