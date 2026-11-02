-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Dan', 50000, 5, '2020-01-02');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Eli', 50000, 5, '2020-01-03');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'Fay', 50000, 5, '2020-01-04');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (5, 'Gus', 50000, 5, '2020-01-05');
INSERT INTO company (com_id, name, city) VALUES (1, 'BLUE', 'NY');
INSERT INTO company (com_id, name, city) VALUES (2, 'red', 'LA');
INSERT INTO company (com_id, name, city) VALUES (3, 'RED_CORP', 'SF');
INSERT INTO company (com_id, name, city) VALUES (4, 'GREEN', 'RED');
INSERT INTO company (com_id, name, city) VALUES (5, 'RED', 'BLUE');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 1, '2021-10-01', 100);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, 2, 2, '2021-10-02', 200);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (3, 3, 3, '2021-10-03', 300);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (4, 4, 4, '2021-10-04', 400);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (5, 5, 5, '2021-10-05', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('Dan',)
('Eli',)
('Fay',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT D.SALES_ID FROM (SELECT S.NAME, S.SALES_ID, O.COM_ID FROM SALESPERSON AS S INNER JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID INNER JOIN COMPANY AS C ON O.COM_ID = C.COM_ID) AS D WHERE D.COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME LIKE '%RED%'));

/*
Prediction Result:
('RED',)
('Fay',)
*/