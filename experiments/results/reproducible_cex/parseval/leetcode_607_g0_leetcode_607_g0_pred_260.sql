-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: salesperson --
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483648, 'sal_15f329', 1644814318, 1465859724, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1, 'sal_4ddf56', 44952191, 1151980946, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (6, 'sal_ef03fb', 546571701, 947159877, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (2, 'sal_2af11d', 1990080517, 1408123494, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (8, 'sal_ef03fb', 283598170, 742285925, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (5, 'sal_2af11d', 226938182, 90119032, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483642, 'sal_4ddf56', 481163439, 2123196517, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483641, 'sal_4ddf56', 2056419640, 222415430, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483640, NULL, 556727997, 1178000634, 'sal_674bfc');

INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (-2147483639, NULL, 1196308825, 910894705, 'sal_674bfc');

-- Inserting into table: company --
INSERT INTO "company" ("com_id", "name", "city") VALUES (1, 'RED', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (3, 'RED', 'com_269673');

INSERT INTO "company" ("com_id", "name", "city") VALUES (4, 'RED', 'com_269673');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (-2147483648, 1, 1, 'ord_9b8b62', 1620389964);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (7, 3, 2, 'ord_9b8b62', 233994589);

INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (9, 4, 5, 'ord_9b8b62', 1442655647);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('sal_15f329',)
('sal_4ddf56',)
('sal_4ddf56',)
(None,)
(None,)
('sal_ef03fb',)
('sal_ef03fb',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON LEFT JOIN (SELECT SALESPERSON.NAME AS SALES_PERSON_NAME FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED') AS FILTER ON SALESPERSON.NAME = FILTER.SALES_PERSON_NAME WHERE FILTER.SALES_PERSON_NAME IS NULL;

/*
Prediction Result:
('sal_15f329',)
(None,)
(None,)
('sal_ef03fb',)
('sal_ef03fb',)
*/