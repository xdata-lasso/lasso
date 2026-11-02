-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salesperson --
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1, 'a_s_603e19', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (2, 'a_s_603e19', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (3, 'a_s_603e19', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (4, 'a_s_603e19', 1620389964, 546571701, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (5, 'a_s_603e19', 947159877, 1990080517, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (6, 'a_s_603e19', 1155439218, 1313172851, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (7, 'a_s_603e19', 775304493, 373262291, 'sal_674bfc');

-- Inserting into table: company --
INSERT INTO "company" ("com_id", "name", "city") VALUES (1, 'RED', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (-2147483647, 'a_s_603e19', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (-2147483646, 'a_s_603e19', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (-2147483645, 'a_s_603e19', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (-2147483644, 'a_s_603e19', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (-2147483643, 'a_s_603e19', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (-2147483642, 'a_s_603e19', 'com_269673');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (-2147483648, 1, 1, 'ord_9b8b62', 1019800248);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('a_s_603e19',)
('a_s_603e19',)
('a_s_603e19',)
('a_s_603e19',)
('a_s_603e19',)
('a_s_603e19',)
*/

-- Prediction Query
SELECT A.NAME FROM SALESPERSON AS A LEFT JOIN (SELECT B.NAME FROM (SELECT S.NAME, O.COM_ID FROM SALESPERSON AS S JOIN ORDERS AS O ON O.SALES_ID = S.SALES_ID) AS B JOIN COMPANY AS C ON B.COM_ID = C.COM_ID WHERE C.NAME = 'RED') AS D ON A.NAME = D.NAME WHERE D.NAME IS NULL;

/*
Prediction Result:
*/