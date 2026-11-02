-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salesperson --
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1, 'sal_cd9682', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (3, 'sal_768dce', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (2, 'sal_2af11d', 1620389964, 546571701, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483645, NULL, 947159877, 1990080517, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483644, 'sal_cd9682', 1155439218, 1313172851, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483643, 'sal_cd9682', 775304493, 373262291, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (4, 'red_a0fb5f', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483641, 'red_a0fb5f', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (5, 'red_a0fb5f', 1620389964, 546571701, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483639, 'red_a0fb5f', 947159877, 1990080517, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (6, 'sal_cd9682', 1155439218, 1313172851, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483637, 'sal_cd9682', 775304493, 373262291, 'sal_674bfc');

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
(None,)
('sal_cd9682',)
('sal_cd9682',)
('red_a0fb5f',)
('red_a0fb5f',)
('sal_cd9682',)
('sal_768dce',)
('red_a0fb5f',)
('red_a0fb5f',)
('sal_cd9682',)
*/

-- Prediction Query
WITH RED_ORDERS AS (SELECT SALESPERSON.NAME FROM ORDERS LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID LEFT JOIN SALESPERSON ON ORDERS.SALES_ID = SALESPERSON.SALES_ID WHERE COMPANY.NAME = 'RED') SELECT SALESPERSON.NAME FROM SALESPERSON LEFT JOIN RED_ORDERS ON RED_ORDERS.NAME = SALESPERSON.NAME WHERE RED_ORDERS.NAME IS NULL;

/*
Prediction Result:
(None,)
('red_a0fb5f',)
('red_a0fb5f',)
('sal_768dce',)
('red_a0fb5f',)
('red_a0fb5f',)
*/