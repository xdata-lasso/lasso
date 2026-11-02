-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'c_s_4e9a8a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_4e9a8a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 't_s_efbb02', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 't_s_efbb02', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 't_s_efbb02');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 't_s_efbb02');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483648, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483648, 'cus_8d1b6b', 1, 0, 0)
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'c_s_4e9a8a', 1, 1, 0)
(-2147483643, 'c_s_4e9a8a', 1, 1, 0)
(-2147483642, 'c_s_4e9a8a', 1, 1, 0)
(1, 'cus_8d1b6b', 1, 1, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(TEMP1.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TEMP2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN (SELECT T.USER_ID, COUNT(*) AS CONTACTS_CNT FROM CONTACTS AS T GROUP BY T.USER_ID) AS TEMP1 ON I.USER_ID = TEMP1.USER_ID LEFT JOIN (SELECT T.USER_ID, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS T WHERE T.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY T.USER_ID) AS TEMP2 ON I.USER_ID = TEMP2.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483648, 'cus_8d1b6b', 1, 0, 0)
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'c_s_4e9a8a', 1, 1, 1)
(-2147483643, 'c_s_4e9a8a', 1, 1, 1)
(-2147483642, 'c_s_4e9a8a', 1, 1, 1)
(1, 'cus_8d1b6b', 1, 1, 1)
*/