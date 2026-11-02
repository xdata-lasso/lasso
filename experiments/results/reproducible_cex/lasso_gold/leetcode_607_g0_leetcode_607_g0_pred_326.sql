-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("com_id", "name", "city") VALUES (1037, 'RED', 'Port Craig');
INSERT INTO "company" ("com_id", "name", "city") VALUES (1045, 'RED', 'Port Craig');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1038, 'Mark Diaz', 1039, 1040, 'hospital');
INSERT INTO "salesperson" ("sales_id", "name", "salary", "commission_rate", "hire_date") VALUES (1043, 'Mark Diaz', 1039, 1040, 'hospital');
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (1041, 1037, 1038, 'hear', 1042);
INSERT INTO "orders" ("order_id", "com_id", "sales_id", "order_date", "amount") VALUES (1044, 1045, 1043, 'hear', 1042);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT T1.SALES_ID FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 WHERE T1.SALES_ID = T2.SALES_ID AND T2.COM_ID = (SELECT COM_ID FROM COMPANY WHERE COMPANY.NAME = 'RED'));

/*
Prediction Result:
('Mark Diaz',)
*/