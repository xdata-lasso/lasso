-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salesperson --
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1, 's2__783f6b', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483647, 's2__783f6b', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483646, 's2__783f6b', 1620389964, 546571701, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (3, 's2__932cd7', 947159877, 1990080517, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483644, NULL, 1155439218, 1313172851, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (2, 'sal_2af11d', 775304493, 373262291, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (4, 'red_216876', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483641, 'red_216876', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (5, 'red_216876', 1620389964, 546571701, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483639, 'red_216876', 947159877, 1990080517, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (6, 's2__783f6b', 1155439218, 1313172851, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483637, 's2__783f6b', 775304493, 373262291, 'sal_674bfc');

-- Inserting into table: company --
INSERT INTO "company" ("com_id", "name", "city") VALUES (1, 'RED', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (2, 'RED', 'com_269673');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (-2147483648, 1, 1, 'ord_9b8b62', 1019800248);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (2, 2, 2, 'ord_9b8b62', 328305758);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('s2__783f6b',)
('s2__783f6b',)
(None,)
('red_216876',)
('red_216876',)
('s2__783f6b',)
('s2__932cd7',)
('red_216876',)
('red_216876',)
('s2__783f6b',)
*/

-- Prediction Query
WITH RED_SALES AS (SELECT S1.NAME FROM SALESPERSON AS S1 JOIN ORDERS AS O ON S1.SALES_ID = O.SALES_ID JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED') SELECT S2.NAME FROM SALESPERSON AS S2 LEFT JOIN RED_SALES ON S2.NAME = RED_SALES.NAME WHERE RED_SALES.NAME IS NULL;

/*
Prediction Result:
(None,)
('red_216876',)
('red_216876',)
('s2__932cd7',)
('red_216876',)
('red_216876',)
*/