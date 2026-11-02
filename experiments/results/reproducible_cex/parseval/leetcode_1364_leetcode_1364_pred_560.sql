-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_d401ce', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, '0', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'c1__ed3673', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (7, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'c1__ed3673', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (11, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (14, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (13, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (10, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'c1__ed3673', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (17, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (20, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (19, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (16, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'c1__ed3673', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (23, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (26, 'c2__7fcd1d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (25, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (22, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_861986');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_861986');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (7, 'con_de12a6', 'c1__ed3673');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (13, 'con_de12a6', 'c1__ed3673');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (19, 'con_de12a6', 'c1__ed3673');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (25, 'con_de12a6', 'c1__ed3673');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (6, 7, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (9, 1, 1871297066);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (12, 13, 809183447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (15, -2147483640, 1744686505);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (18, 19, 1115440883);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (21, 10, 1465859724);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (24, 25, 1019800248);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (27, 14, 1526238907);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'c_s_d401ce', 1, 1, 0)
(2, 'c_s_d401ce', 1, 1, 0)
(6, 'cus_8d1b6b', 247012447, 1, 0)
(9, 'c_s_d401ce', 1871297066, 1, 0)
(12, 'cus_8d1b6b', 809183447, 1, 0)
(15, 'c1__ed3673', 1744686505, 0, 0)
(18, 'cus_8d1b6b', 1115440883, 1, 0)
(21, 'cus_8d1b6b', 1465859724, 0, 0)
(24, 'cus_8d1b6b', 1019800248, 1, 0)
(27, 'c2__7fcd1d', 1526238907, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(COUNT(C1.USER_ID), 0) AS CONTACTS_CNT, COALESCE(COUNT(C2.CUSTOMER_NAME), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, CONTACT_NAME FROM CONTACTS) AS C1 ON I.USER_ID = C1.USER_ID LEFT JOIN CUSTOMERS AS C2 ON C1.CONTACT_NAME = C2.CUSTOMER_NAME GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'c_s_d401ce', 1, 1, 0)
(2, 'c_s_d401ce', 1, 1, 0)
(6, 'cus_8d1b6b', 247012447, 4, 4)
(9, 'c_s_d401ce', 1871297066, 1, 0)
(12, 'cus_8d1b6b', 809183447, 4, 4)
(15, 'c1__ed3673', 1744686505, 0, 0)
(18, 'cus_8d1b6b', 1115440883, 4, 4)
(21, 'cus_8d1b6b', 1465859724, 0, 0)
(24, 'cus_8d1b6b', 1019800248, 4, 4)
(27, 'c2__7fcd1d', 1526238907, 0, 0)
*/